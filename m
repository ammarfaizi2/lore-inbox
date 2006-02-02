Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWBBUx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWBBUx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBBUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:53:57 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5250 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932230AbWBBUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:53:56 -0500
Subject: Re: Wanted: hotfixes for -mm kernels
From: Lee Revell <rlrevell@joe-job.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602021502_MC3-1-B772-547@compuserve.com>
References: <200602021502_MC3-1-B772-547@compuserve.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 15:53:52 -0500
Message-Id: <1138913633.15691.109.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 15:00 -0500, Chuck Ebbert wrote:
> Most -mm kernels have small but critical bugs that are found shortly
> after release.  Patches for these are posted on linux-kernel but
> they aren't made available on kernel.org until the next -mm release.
> 
> Would it be possible to create a hotfix/ directory for each -mm
> release and put those patches there?  A README could explain that
> the fixes are untested.  At least people reading the files could
> see an issue exists even if they're not brave enough to try the
> patch. :)

I doubt it - mm is an experimental kernel, hotfixes only make sense for
production stuff.  It moves too fast.

A better question is what does -mm give you that mainline does not, that
causes you to want to "stabilize" a specific -mm version?

Lee

