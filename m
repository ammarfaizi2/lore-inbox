Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSKVN3Q>; Fri, 22 Nov 2002 08:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSKVN3Q>; Fri, 22 Nov 2002 08:29:16 -0500
Received: from chico.rediris.es ([130.206.1.3]:60065 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id <S264715AbSKVN3P>;
	Fri, 22 Nov 2002 08:29:15 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: kernel oopsing in ftp.es.debian.org.
Date: Fri, 22 Nov 2002 14:36:22 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200211201226.18015.ender@debian.org> <200211201648.58812.ender@debian.org> <1037809464.3702.45.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1037809464.3702.45.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211221436.22237.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mié 20 Nov 2002 17:24, Alan Cox escribió:
> On Wed, 2002-11-20 at 15:48, David Martínez Moreno wrote:
> > 	The last kernel that it ran stably I think that was 2.4.19-pre10. I can
> > reboot with this kernel, because the machine has hung again. One more
> > reboot doesn't mind. :-(
>
> Stick the last stable kernel on it and see if becomes stable again. My
> first guess is you've developed a hardware problem, going back to the
> old kernel will eliminate that doubt

	Hello, Alan, it's me again.

	You were right. After running memtest86 on the box for some time, it began to 
spit a lot of errors along the whole 512 MB DIMM.

	I've replaced the DIMM with a smaller one and had asked for a replacement 
(thankfully it was under warranty yet). ftp.es.debian.org is up and happily 
running again.

	Thank you for your support, you people in l-k.


		Ender.
-- 
 Why is a cow? Mu. (Ommmmmmmmmm)
--
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05

