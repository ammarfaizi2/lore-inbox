Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbRGEMrQ>; Thu, 5 Jul 2001 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbRGEMrG>; Thu, 5 Jul 2001 08:47:06 -0400
Received: from ns1.actimage.fr ([194.79.162.35]:3379 "EHLO ns1.actimage.fr")
	by vger.kernel.org with ESMTP id <S265077AbRGEMqz>;
	Thu, 5 Jul 2001 08:46:55 -0400
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols since 2.4.5 ?
In-Reply-To: <873d8b4kve.fsf@galaxie.alplog.net> <20010705143944.J30999@arthur.ubicom.tudelft.nl>
From: Cyril ADRIAN <c.adrian@alplog.fr>
In-Reply-To: Erik Mouw's message of "Thu, 5 Jul 2001 14:39:44 +0200"
Date: 05 Jul 2001 14:48:52 +0200
Message-ID: <87wv5n35jf.fsf@galaxie.alplog.net>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello,

    Thank you for your fast answer :o)

>>>>> "Erik" == Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> writes:

    Erik> Looks like your system has an old version of modutils. You need Adrian
    Erik> Bunk's linux-2.4 packages for running linux-2.4.* with Debian potato.
    Erik> Add the following two lines to /etc/apt/sources.list:

    Erik> deb http://people.debian.org/~bunk/debian potato main
    Erik> deb-src http://people.debian.org/~bunk/debian potato main

    I have just the first line of those. dpkg --list | grep modutils shows:

ii  modutils       2.4.6-2.bunk   Linux module utilities.

    Is it OK?

        Cyril
-- 
Cyril ADRIAN                                   ALPLOG F-67400 ILLKIRCH
+33 (0)6 70 55 10 60                              +33 (0)3 90 40 00 00
mailto:cadrian@ifrance.com                   mailto:c.adrian@alplog.fr
http://sourceforge.net/projects/smerge            http://www.alplog.fr
