Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSJaQru>; Thu, 31 Oct 2002 11:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbSJaQru>; Thu, 31 Oct 2002 11:47:50 -0500
Received: from mario.gams.at ([194.42.96.10]:22093 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S262876AbSJaQq5> convert rfc822-to-8bit;
	Thu, 31 Oct 2002 11:46:57 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Matt Porter <porter@cox.net>
cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY 
References: <20021031100855.A3407@home.com> 
In-reply-to: Your message of "Thu, 31 Oct 2002 10:08:55 MST."
             <20021031100855.A3407@home.com> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 31 Oct 2002 17:52:59 +0100
Message-ID: <22051.1036083179@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <porter@cox.net> wrote:
>Thank you.  This is exactly why in the last CONFIG_TINY thread I made
>it clear that a one-size-fits-all option is not all that helpful for
>serious embedded systems designers.
>
>Collecting these parameters in a single tweaks.h file and perhaps using
>things like CONFIG_TINY, CONFIG_DESKTOP, CONFIG_FOO as profile selectors

In an ideal world there would be several options invidually 
selectable.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


