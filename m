Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131542AbQK0Ex3>; Sun, 26 Nov 2000 23:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132485AbQK0ExT>; Sun, 26 Nov 2000 23:53:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13316 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S131542AbQK0ExL>; Sun, 26 Nov 2000 23:53:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: syslinux and 2.4.0 initrd size problems
Date: 26 Nov 2000 20:22:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vsniu$pb9$1@cesium.transmeta.com>
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001126211642.A2763@vger.timpanogas.org>
By author:    "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
In newsgroup: linux.dev.kernel
> 
> I am having trouble getting a 2.4 vmlinuz (bzImage) and initrd 
> image onto a 1.44 floppy with all the new stuff.  Even a stipped 
> down kernel compiled under 2.4 is @ 600K compressed, and I need 
> about 800K for the initrd image.  I noticed that syslinux 
> has some comments about not allowing initrd to span media.  
> 
> I there something more current that does or will allow me to
> load the inittrd off a CD-ROM device (with vmlinuz and syslinux
> on the floppy).   I know how to do this with GRUB (Grand 
> Unified Boot Loader), but I want to use syslinux if possible. 
> 

Why are you posting this to the kernel list?  See the SYSLINUX
documentation for the SYSLINUX mailing list address.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
