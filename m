Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVCaRMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVCaRMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCaRMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:12:00 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22418 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261571AbVCaRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:11:50 -0500
Subject: Re: forkbombing Linux distributions
From: Lee Revell <rlrevell@joe-job.com>
To: Natanael Copa <mlists@tanael.org>
Cc: Jacek =?iso-8859-2?Q?=A3uczak?= <difrost@pin.if.uz.zgora.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1112263230.1165.15.camel@nc>
References: <424AE48C.8000805@pin.if.uz.zgora.pl>
	 <1112263230.1165.15.camel@nc>
Content-Type: text/plain; charset=iso-8859-2
Date: Thu, 31 Mar 2005 12:11:46 -0500
Message-Id: <1112289106.1829.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 12:00 +0200, Natanael Copa wrote:
> On Wed, 2005-03-30 at 19:40 +0200, Jacek £uczak wrote:
> > 
> > I made some tests and almost all Linux distros brings down while freebsd 
> > survive!Forkbombing is a big problem but i don't think that something like

> I really liked this approach because:

Christ, why is this idiotic thread still going?  No one is going to
change the kernel, because the problem is trivial to solve in userspace!
Didn't you ever look up what a ulimit is?

If you consider your distro's default ulimits unreasonable, file a bug
report with them.  But no one is going to make Linux "restrictive by
default" to make life easier for people who don't bother to RTFM.

Lee


