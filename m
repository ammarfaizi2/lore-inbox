Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSANAO4>; Sun, 13 Jan 2002 19:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288395AbSANAOq>; Sun, 13 Jan 2002 19:14:46 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:37905 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288377AbSANAOa>;
	Sun, 13 Jan 2002 19:14:30 -0500
Date: Sun, 13 Jan 2002 17:11:40 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>, jogi@planetzork.ping.de,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113171140.B17958@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <E16PtX0-0000VA-00@starship.berlin> <1010962587.813.22.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1010962587.813.22.camel@phantasy>; from rml@tech9.net on Sun, Jan 13, 2002 at 05:56:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 05:56:25PM -0500, Robert Love wrote:
> On Sun, 2002-01-13 at 17:55, Daniel Phillips wrote:
> 
> > I'd like to add my 'me too' to those who have requested a re-run of this test, building
> > the *identical* kernel tree every time, starting from the same initial conditions.
> > Maybe that's what you did, but it's not clear from your post.
> 
> He later said he did in fact build the same tree, from the same initial
> condition, in single user mode, etc etc ... sounded like good testing
> methodology to me.

Really? You think that 
		unpack a tar archive
		make

is a repeatable benchmark?
