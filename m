Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTA1RYN>; Tue, 28 Jan 2003 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTA1RYN>; Tue, 28 Jan 2003 12:24:13 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:5112 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267435AbTA1RYM>;
	Tue, 28 Jan 2003 12:24:12 -0500
Date: Tue, 28 Jan 2003 18:33:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "alberto.rodriguez@nullzone.org" <alberto.rodriguez@nullzone.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel and BIOS doesnt give same info about IDE disks here
Message-ID: <20030128173327.GA3504@win.tue.nl>
References: <5.1.1.6.2.20030128180909.02545fe0@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.1.6.2.20030128180909.02545fe0@192.168.2.131>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 06:10:50PM +0100, alberto.rodriguez@nullzone.org wrote:

> server01:/home2# lilo
> Warning: Int 0x13 function 8 and function 0x48 return different
> head/sector geometries for BIOS drive 0x81
>     fn 08: 1024 cylinders, 255 heads, 63 sectors
>     fn 48: 16383 cylinders, 16 heads, 63 sectors
> Warning: Int 0x13 function 8 and function 0x48 return different
> head/sector geometries for BIOS drive 0x84
>     fn 08: 1024 cylinders, 255 heads, 63 sectors
>     fn 48: 16383 cylinders, 16 heads, 63 sectors
> Warning: Kernel & BIOS return differing head/sector geometries for device 
> 0x80
>     Kernel: 5086 cylinders, 16 heads, 63 sectors
>       BIOS: 635 cylinders, 128 heads, 63 sectors
> 
> any idea?
> need more info?

Nothing is wrong.
