Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276073AbRI1Oes>; Fri, 28 Sep 2001 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276074AbRI1Oe3>; Fri, 28 Sep 2001 10:34:29 -0400
Received: from firewall.fesppr.br ([200.238.157.11]:26617 "EHLO
	smtp2.fesppr.br") by vger.kernel.org with ESMTP id <S276073AbRI1Oe0>;
	Fri, 28 Sep 2001 10:34:26 -0400
To: LKML <linux-kernel@vger.kernel.org>
Subject: Trouble booting on a cciss raid
Message-ID: <1001687686.3bb48a86808a7@webmail.fesppr.br>
Date: Fri, 28 Sep 2001 11:34:46 -0300 (BRT)
From: Alexandre Hautequest <hquest@fesppr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.4
X-Originating-IP: 172.16.40.2
X-WebMail-Company: Fundacao de Estudos Sociais do Parana
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

i cant boot on a sa 5300 (cciss driver) raid controller. the boot device is the
floppy kernel used to install the system, who ram without problems.

the cciss driver inits sucessfully, recognizes the logical disks and partitions,
but returns me "VFS: Unable to open root device 00:cc".

ideas? this is a slack 8, 2.2.19.

please cc me as im not subscribed on the ml.

tia.

--
Alexandre Hautequest - hquest at fesppr.br
Fundação de Estudos Sociais do Paraná - http://www.fesppr.br/
Centro de Administração de Redes - CAR
"Procura-se namorada. Interessadas enviar currículum com foto recente, colorida
e datada, habilidades e pretensões."

Registered Linux User #116289 http://counter.li.org/

"Ninguém é melhor do que todos nós juntos."
Equipe Zeus Competições - www.gincaneiros-zeus.com.br

-------------------------------------------------
Esta mensagem foi enviada pelo WebMail da FESP.
Conheça a FESP: http://www.fesppr.br/
