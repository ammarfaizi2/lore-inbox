Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRDIPsq>; Mon, 9 Apr 2001 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRDIPsh>; Mon, 9 Apr 2001 11:48:37 -0400
Received: from mail.ureach.com ([63.150.151.36]:12815 "EHLO ureach.com")
	by vger.kernel.org with ESMTP id <S132593AbRDIPsX>;
	Mon, 9 Apr 2001 11:48:23 -0400
Date: Mon, 9 Apr 2001 11:48:23 -0400
Message-Id: <200104091548.LAA05492@www22.ureach.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
From: Kapish K <kapish@ureach.com>
Reply-to: <kapish@ureach.com>
Subject: Re: Re: nfs performance at high loads
cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-vsuite-type: e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	Thanks for the inputs.. But, if we cannot move back to 2.2.19
and need to stick with 2.4.0 for our own reasons concerning the
work underway, would it be possible to give us a pointer us to
the list of issues related to this problem in the vm, so that we
may attempt to try and get some fixes or workarounds done -
well, they may or may not be accepted into mainstream linux for
various reasons, but we may need to get them fixed to ship our
stuff and may plan to do so..
	Any pointers, suggestions, opinions, etc. are most welcome..
Thanks




________________________________________________
Get your own "800" number
Voicemail, fax, email, and a lot more
http://www.ureach.com/reg/tag


---- On Wed, 4 Apr 2001, Alan Cox (alan@lxorguk.ukuu.org.uk)
wrote:

> > 	We have been seeing some problems with running nfs
benchmarks
> > at very high loads and were wondering if somebody could show
> > some pointers to where the problem lies.
> > 	The system is a 2.4.0 kernel on a 6.2 Red at distribution (
so
> 
> Use 2.2.19. The 2.4 VM is currently too broken to survive high
I/O
> benchmark
> tests without going silly
> 
> 
> 

