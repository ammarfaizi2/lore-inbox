Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTAGPyw>; Tue, 7 Jan 2003 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTAGPyw>; Tue, 7 Jan 2003 10:54:52 -0500
Received: from web11102.mail.yahoo.com ([216.136.131.149]:27194 "HELO
	web11102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267407AbTAGPyv>; Tue, 7 Jan 2003 10:54:51 -0500
Message-ID: <20030107160330.65294.qmail@web11102.mail.yahoo.com>
Date: Tue, 7 Jan 2003 13:03:30 -0300 (ART)
From: "=?iso-8859-1?q?Rodrigo=20F.=20Baroni?=" <rodrigobaroni@yahoo.com.br>
Reply-To: rodrigobaroni@yahoo.com.br
Subject: 2.4.18 compile error : nro_smp not defined
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

   I had tried to compile a 2.4.18 kernel in a pentium
233mhz mmx (lmr591 mother-board - all cards on-board)
and the same kernel at a Pentium III 550mhz (asus p299
mother-board - all cards off-board), and I´m putting
no support to smp (like it´s not a multi-processor
motherboard), but I had got a error that say "nro_smp
not defined" when I do %make bzImage (after a %make
dep).

    Does anybody knows what is going on?

 Rodrigo F Baroni
Computer Science Grad Student
Sao Paulo,Brazil

_______________________________________________________________________
Busca Yahoo!
O melhor lugar para encontrar tudo o que você procura na Internet
http://br.busca.yahoo.com/
