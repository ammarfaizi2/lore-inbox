Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHTVh0>; Mon, 20 Aug 2001 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbRHTVhH>; Mon, 20 Aug 2001 17:37:07 -0400
Received: from firewall.fesppr.br ([200.238.157.11]:1270 "EHLO smtp2.fesppr.br")
	by vger.kernel.org with ESMTP id <S269436AbRHTVhA>;
	Mon, 20 Aug 2001 17:37:00 -0400
To: linux-kernel@vger.kernel.org
Subject: IPX in 2.4.[5-9]
Message-ID: <998343425.3b818301718cd@webmail.fesppr.br>
Date: Mon, 20 Aug 2001 18:37:05 -0300 (BRT)
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

What's the actual IPX support in linux? Is it broken since 2.4.7? Or i just need
to recompile my tools against a new kernel version -- the old ones was compiled
in a 2.4.5 -- with any patch, option, whatever?

hquest@condor:~$ dmesg
(snip)
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
hquest@condor:~$ /sbin/ifconfig -v eth0    
eth0      Link encap:Ethernet  HWaddr 00:00:F8:08:BD:A1  
          inet addr:172.16.40.2  Bcast:172.16.255.255  Mask:255.255.0.0
          IPX/Ethernet 802.2 addr:AC100000:0000F808BDA1
(snip)
hquest@condor:~$ slist
slist: Server not found (0x8847) in ncp_open
hquest@condor:~$ _

Not flaming anyone, just questioning.

Please cc me, as im not subscribed to list.

TIA

--
Alexandre Hautequest - hquest at fesppr.br
Fundação de Estudos Sociais do Paraná - http://www.fesppr.br/
Centro de Administração de Redes - CAR
"Eu acreditava no sistema. Até que eles formataram minha família"

Registered Linux User #116289 http://counter.li.org/

"Ninguém é melhor do que todos nós juntos."
Equipe Zeus Competições - www.gincaneiros-zeus.com.br

-------------------------------------------------
Esta mensagem foi enviada pelo WebMail da FESP.
Conheça a FESP: http://www.fesppr.br/
