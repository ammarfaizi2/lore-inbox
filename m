Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKTPl4>; Wed, 20 Nov 2002 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSKTPl4>; Wed, 20 Nov 2002 10:41:56 -0500
Received: from chico.rediris.es ([130.206.1.3]:42184 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id <S261339AbSKTPlz>;
	Wed, 20 Nov 2002 10:41:55 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: kernel oopsing in ftp.es.debian.org.
Date: Wed, 20 Nov 2002 16:48:58 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200211201226.18015.ender@debian.org> <1037800230.3241.4.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1037800230.3241.4.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211201648.58812.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Nov 2002 14:50, Alan Cox wrote:
> On Wed, 2002-11-20 at 11:26, David Martínez Moreno wrote:
> > 	Hello, dear kernel developers.
> >
> > 	I'm just desperated. ftp.es.debian.org is oopsing again and again with a
> > lot of errors and I don't know what's happening.
>
> What was the last kernel it ran stably ?

	Hi, Alan.

	The last kernel that it ran stably I think that was 2.4.19-pre10. I can 
reboot with this kernel, because the machine has hung again. One more reboot 
doesn't mind. :-(

	Could be a filesystem issue? The power line that the box is connected to 
fails a lot, and this machine has faced a lot of sudden shutdowns, so maybe 
reiserfs or ext3 is giving problems. But all the Debian archive is on a 
reiserfs partition, so we couldn't test if the problem is triggered by Apache 
or reiserfs in such way (or maybe I'm missing something?).

	I have oopses for -pre8, if you wish, from smbd, apache, sshd, etc.

	I can do nearly whatever you want in the machine. Now is nearly unusable.

	Thank you in advance,


		Ender.
-- 
 Why is a cow? Mu. (Ommmmmmmmmm)
--
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05

