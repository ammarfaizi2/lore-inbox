Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSJ3IQU>; Wed, 30 Oct 2002 03:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSJ3IQU>; Wed, 30 Oct 2002 03:16:20 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:37019
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264620AbSJ3IQT>; Wed, 30 Oct 2002 03:16:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 03:22:17 -0500
User-Agent: KMail/1.4.2
Cc: landley@trommello.org, linux-kernel@vger.kernel.org, reiser@namesys.com,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com, boissiere@adiglobal.com
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com>
In-Reply-To: <3DBF8CD5.1030306@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300322.17933.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 2:40, Jeff Garzik wrote:

> untar - cpio is better.

CPIO is commonly used and supported by NO ONE. (rpm, whoppee)
Kernels even come tar'ed. KISS....

> initrd - 99% moved out of the kernel

Great...you just killed the high level embedded linux market, and
the ability to play boot games from GRUB. (Network, etc)
Initrd is a good **OPTION* to have to fall back on...

> do_mounts - moved out of the kernel completely

And he's willing to completely purge initrd and do_mounts NOW???

> initramfs - should be ready for Linus in the next day or so.

Fire away with the 100K+ bloated POS. I'm backwards compatible,
could easily add 'linked kernel image' support, and only increase
the current code by 20K.

> None of that junk -- and a whole lot more -- needs to be in the kernel
> at all.

Do you have any serious sysadmin, clustering, or emebedded system
IMPLEMENTATION experience? 

Dave

-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/

