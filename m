Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSJaWWx>; Thu, 31 Oct 2002 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265416AbSJaWWw>; Thu, 31 Oct 2002 17:22:52 -0500
Received: from AGrenoble-101-1-6-18.abo.wanadoo.fr ([80.11.197.18]:5275 "EHLO
	awak") by vger.kernel.org with ESMTP id <S265400AbSJaWWw> convert rfc822-to-8bit;
	Thu, 31 Oct 2002 17:22:52 -0500
Subject: Re: What's left over.
From: Xavier Bestel <xavier.bestel@free.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031225729.GD4331@elf.ucw.cz>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu> 
	<20021031225729.GD4331@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 23:28:54 +0100
Message-Id: <1036103335.25512.40.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 31/10/2002 à 23:57, Pavel Machek a écrit :

> This seems like a pretty common situation to me, and current solutions
> are not nice. [I guess ~/bin/ with --x and
> ~/bin/my-secret-password-only-jarka-and-mj-knows/phonebook would solve
> the problem, but...!]

Can't even this be spied from /proc/*/fd ?


