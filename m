Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSF0IL6>; Thu, 27 Jun 2002 04:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSF0IL5>; Thu, 27 Jun 2002 04:11:57 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:45209
	"EHLO awak") by vger.kernel.org with ESMTP id <S316757AbSF0IL5> convert rfc822-to-8bit;
	Thu, 27 Jun 2002 04:11:57 -0400
Subject: Re: New Zaurus Wishlist - removable media handling
From: Xavier Bestel <xavier.bestel@free.fr>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D1A75FD.6010801@sktc.net>
References: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer> 
	<3D1A75FD.6010801@sktc.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 27 Jun 2002 10:11:51 +0200
Message-Id: <1025165512.1078.91.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 27/06/2002 à 04:18, David D. Hagood a écrit :
> Tomasz Rola wrote:
> 
> > As a former Amiga user and now yet another Linux user, I probably know
> > what you mean. Well, I'm not a kernel engineer but maybe it could be done
> > with a virtual fs like /dev - so that
> 
> This sounds like autofs - you'd just need a program to scan all 
> available removable block devices, and look for a "label" to ID the 
> media - either a (V)FAT label, or an EXT(23) label, or XFS label, or....
> 
> Then you mount the named volume as needed, with a 10 second umount 
> timeout, so that you can remove it easily.

timeouts are *evil*. 


