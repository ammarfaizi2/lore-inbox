Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRDQQYW>; Tue, 17 Apr 2001 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRDQQYN>; Tue, 17 Apr 2001 12:24:13 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132744AbRDQQYH>; Tue, 17 Apr 2001 12:24:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mylex DAC vs RAM disk in 2.4.2 devfs
Date: 17 Apr 2001 09:23:45 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bhqmh$50d$1@cesium.transmeta.com>
In-Reply-To: <01041713220107.28478@lyta> <20010417140859.E4385@kallisto.sind-doof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010417140859.E4385@kallisto.sind-doof.de>
By author:    Andreas Ferber <aferber@techfak.uni-bielefeld.de>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> On Tue, Apr 17, 2001 at 01:22:01PM +0200, Russell Coker wrote:
> 
> > Mylex controllers for a long time.  I am willing to submit patches to the 
> > kernel and to devfsd if this suggestion is accepted and someone can suggest a 
> > good directory name for ram-disks (I don't want to have the same problem 
> > again).
> 
> What about simply "ramdisk"? ;-)
> 

The standard name is /dev/ramX.  If you want it directorized I suggest
/dev/ram/X.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
