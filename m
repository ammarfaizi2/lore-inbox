Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYTlc>; Thu, 25 Jan 2001 14:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAYTlX>; Thu, 25 Jan 2001 14:41:23 -0500
Received: from firewall.fesppr.br ([200.238.157.11]:20986 "EHLO
	smtp2.fesppr.br") by vger.kernel.org with ESMTP id <S129101AbRAYTlJ>;
	Thu, 25 Jan 2001 14:41:09 -0500
To: linux-kernel@vger.kernel.org
Subject: non-random IP IDs
Message-ID: <980451650.3a7081428753c@webmail.fesppr.br>
Date: Thu, 25 Jan 2001 17:40:50 -0200 (BRST)
From: Alexandre Hautequest <hquest@fesppr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 172.16.60.100
X-WebMail-Company: Fundacao de Estudos Sociais do Parana
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I was playing a bit on some of my machines with Nessus (www.nessus.org), and it
told me the following text:

    "The remote host uses non-random IP IDs, that is, it is
     possible to predict the next value of the ip_id field of
     the ip packets sent by this host.

     An attacker may use this feature to determine if the remote
     host sent a packet in reply to another request. This may be
     used for portscanning and other things.

     Solution : Contact your vendor for a patch
     Risk factor : Low"

Is there some option to dinamically enable this random IP ID's, or I need to 
change something and recompile, or just "No way!"?

Please cc me as i'm not subscribed to the list.

Thanks in advance.

--
Alexandre Hautequest
hquest at fesppr.br

"Globalização: Um paraguaio dirigindo pelas estradas brasileiras um carro 
francês fabricado na Argentina ouvindo música americana num som japonês."

-------------------------------------------------
Esta mensagem foi enviada pelo WebMail da FESP.
Conheça a FESP: http://www.fesppr.br/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
