Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWAMRyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWAMRyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWAMRyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:54:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43464 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422751AbWAMRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:54:10 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:54:08 -0500
Message-Id: <1137174848.15108.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 12:52 -0500, Steven Rostedt wrote:
> On Fri, 13 Jan 2006, Lee Revell wrote:
> 
> > I don't have hardware to test this, can you confirm that the only
> > workaround needed is to boot with "clock=pmtmr"?
> 
> For which kernel?

I believe the problem exists on all kernels, it should not matter.

Lee

