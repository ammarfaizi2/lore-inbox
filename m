Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbTLZTyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbTLZTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:54:40 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:39787 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265217AbTLZTyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:54:39 -0500
Message-ID: <3FEC91FA.1050705@rackable.com>
Date: Fri, 26 Dec 2003 11:54:34 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Can't eject a previously mounted CD?
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org>
In-Reply-To: <20031226194457.GC12871@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2003 19:54:34.0679 (UTC) FILETIME=[15E79470:01C3CBEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> On Fri, Dec 26, 2003 at 11:34:27AM +0100, Vojtech Pavlik wrote:
> 
>>If you're using SUSE 9.0 ...
> 
> 
> No, Debian.
> 
> The reason I said it was something to do with my motherboard is that
> I've not experienced this before, even on another motherboard with
> the original nForce.
> 
> Traditionally (as in Windows), the only thing that would keep the CD
> from being ejected is an ongoing recording session. Of course, in
> Linux, it just has to be mounted, and that's normal behavior. Just that
> the drive doesn't want to eject my CD even after unmounting it.
> Does that mean that this is a userspace problem?
> 

   What does fuser -kv /mnt/cdrom claim?

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

