Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSCXSEU>; Sun, 24 Mar 2002 13:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311661AbSCXSEB>; Sun, 24 Mar 2002 13:04:01 -0500
Received: from mario.gams.at ([194.42.96.10]:15152 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S311642AbSCXSD4> convert rfc822-to-8bit;
	Sun, 24 Mar 2002 13:03:56 -0500
Message-Id: <200203241803.g2OI3sW30448@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory 
In-Reply-To: <200203241757.SAA20700@piggy.rz.tu-ilmenau.de> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 24 Mar 2002 19:03:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntr ger <linux-kernel@borntraeger.net> wrote:
>Well, I think could be worth in terms of security, because a local user could 
>use a bad memory-eating program to produce an Denial of Service of other 
>processes.

man setrlimit

>Unfortunately detecting a program, written to cause harm is harder than 
>detecting a crazy program.

ACK.
	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


