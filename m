Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292307AbSBPBWA>; Fri, 15 Feb 2002 20:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292308AbSBPBVu>; Fri, 15 Feb 2002 20:21:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33549
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292307AbSBPBVb>; Fri, 15 Feb 2002 20:21:31 -0500
Date: Fri, 15 Feb 2002 17:10:37 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Nick Urbanik <nicku@vtc.edu.hk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cmd649 not working with 2 CPU box; what IDE card should I use?
In-Reply-To: <3C6C7F29.DE677AB4@vtc.edu.hk>
Message-ID: <Pine.LNX.4.10.10202151709100.10501-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Nick Urbanik wrote:

> Dear folks,
> 
> I have tried cmd649 ATA pci cards; they work great with single CPU
> kernels, not at all with SMP kernels.  The SMP kernel just does not make
> an entry in /proc/ide.  Some details are in my post on 13 Feb, with
> subject: cmd649 ok 1 cpu, 2 cpus, not working.  I would appreciate any
> pointers that may lead to getting them working.
> 
> So if this is not a common problem, does _anyone_ use ATA cards with SMP
> boxes?  If so, which ones work?  HPT?


LOL, I had the same question asked to me by CMD and probed to them it
works.  Obviously you have not configured something correct :-/

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

