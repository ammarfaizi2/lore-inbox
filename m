Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRLKRv2>; Tue, 11 Dec 2001 12:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281890AbRLKRvS>; Tue, 11 Dec 2001 12:51:18 -0500
Received: from rj.SGI.COM ([204.94.215.100]:42409 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281874AbRLKRvM>;
	Tue, 11 Dec 2001 12:51:12 -0500
Date: Tue, 11 Dec 2001 11:51:02 -0600
From: Nathan Straz <nstraz@sgi.com>
To: Khyron <khyron@khyron.com>
Cc: LKML - Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Test Project <ltp-list@lists.sourceforge.net>
Subject: Re: Kernel test suites (was Re: Coding style - a non-issue)
Message-ID: <20011211115102.A1637@sgi.com>
Mail-Followup-To: Khyron <khyron@khyron.com>,
	LKML - Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Test Project <ltp-list@lists.sourceforge.net>
In-Reply-To: <Pine.BSF.4.33.0112032202420.98724-100000@four.malevolentminds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.33.0112032202420.98724-100000@four.malevolentminds.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 10:28:44PM +0000, Khyron wrote:
> I would be interested in seeing this test suite as well.
> 
> Also, if anyone with any background on the subject can
> chime in on the RH test suite and how the Linux Test Project
> compare/overlap/differ, that would be good to know too.

The bulk of LTP is regression tests.  There are a number of stress tests
in LTP, but not the ones in the RH test suite (if the one below is
correct).  Also, LTP doesn't use CTCS, but its own test driver.  

> Alan Cox previously replied to Stanislav Meduna saying:
> > Is the test suite (or at least part of it) public, or is it
> > considered to be a trade-secret of Red Hat? I see there
> > is a "Red Hat Ready Test Suite" - is this a part of it?
> 
> The main Red Hat test suite is a version of Cerberus (originally from VA
> and much extended), its all free software and its available somewhere
> although I don't have the URL to hand, Arjan ?

I'm not sure if this is it or not, but this is the package I was once
pointed to.

http://people.redhat.com/bmatthews/cerberus/stress-kernel-*


-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
