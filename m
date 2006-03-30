Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWC3U4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWC3U4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWC3U4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:56:12 -0500
Received: from fmr19.intel.com ([134.134.136.18]:19401 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750869AbWC3U4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:56:10 -0500
Date: Thu, 30 Mar 2006 12:55:38 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Tushar <tushar.telichari@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: DTrace for Linux
Message-ID: <20060330205537.GF16173@goober>
References: <323d1f6f0603282214m4a2c65b0t2e2bf7e74352e5f@mail.gmail.com> <20060328225203.7443c09f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328225203.7443c09f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 10:52:03PM -0800, Randy.Dunlap wrote:
> On Wed, 29 Mar 2006 11:44:47 +0530 Tushar wrote:
> 
> > Hi Guys,
> > 
> > I am planning to port DTrace (Solaris 10) utility to Linux. I have
> > done good enough research for same. Is this port of DTrace to Linux
> > already been started/completed ?
> > 
> > Please let me know your comments on this.
> 
> based on what I hear, http://sourceware.org/systemtap/
> is the Linux version...

Background: I worked for Sun in the Solaris group during DTrace's
development.  I was probably one of the first 30 people to use DTrace,
and actively used it for kernel development for over a year.

Randy didn't say this, but in case anyone got the wrong impression,
SystemTap is not a port of DTrace.  SystemTap has existed as its own
project for quite some time.  One of the current goals of SystemTap is
to provide equivalent functionality to DTrace in some areas.

My opinion is that a port of DTrace to Linux would be extremely
valuable, above and beyond the goals of SystemTap.  It is also my
opinion that it will be extremely difficult. :)

-VAL
