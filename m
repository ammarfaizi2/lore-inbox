Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286857AbRLWJsh>; Sun, 23 Dec 2001 04:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286854AbRLWJs1>; Sun, 23 Dec 2001 04:48:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7685 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286852AbRLWJsP>; Sun, 23 Dec 2001 04:48:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: 23 Dec 2001 01:47:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a04989$7n0$1@cesium.transmeta.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D81C@orsmsx111.jf.intel.com> <m1r8pmqotz.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1r8pmqotz.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> GRUB allows some very neat things and it allows for it with the
> multiboot stuff.  And everyone seems to assume that because what you
> can do with GRUB is good, multiboot must be good as well.  But have
> you ever wondered why no other bootloader implementor was interested?
> 

Very well said!!  I really think that an initramfs protocol which
allows (but does not require!!) synthesis in the boot loader is the
way to go.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
