Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275087AbRJAOBU>; Mon, 1 Oct 2001 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275086AbRJAOBK>; Mon, 1 Oct 2001 10:01:10 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19670 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275110AbRJAOAx>; Mon, 1 Oct 2001 10:00:53 -0400
Subject: Re: kernel changes
From: Paul Larson <plars@austin.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Frazer <mark@somanetworks.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E15n6CR-00008r-00@the-village.bc.nu>
In-Reply-To: <E15n6CR-00008r-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 01 Oct 2001 09:07:07 +0000
Message-Id: <1001927233.8597.6.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2001 23:33:39 +0100, Alan Cox wrote:
> > The answer is to treat all linus/ac/aa/... kernels as development
> > kernels.  Don't treat anything as stable until it's been through
> > a real QA cycle.  I've heard Suse, RedHat and the like don't do a
> > bad job at this.
> 
> We try. If you want to QA your own kernel the cerberus test suite is
> publically available - and indeed the VA guys are to thank for its origins.
> 
> Alan

For Linux QA/Testing, you may also want to check out the Linux Test
Project.  We just had a new release that added about 400 new testcases
which is way up from what we had before.  We also have descriptions for
all the tests now too.

-Paul Larson

