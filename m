Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTIDCEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTIDCEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:04:30 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16908
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264515AbTIDCE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:04:29 -0400
Date: Wed, 3 Sep 2003 19:04:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-ID: <20030904020445.GN16361@matchmail.com>
Mail-Followup-To: Diego Calleja Garc?a <diegocg@teleline.es>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030902231812.03fae13f.akpm@osdl.org> <20030904010852.095e7545.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904010852.095e7545.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:08:52AM +0200, Diego Calleja Garc?a wrote:
> El Tue, 2 Sep 2003 23:18:12 -0700 Andrew Morton <akpm@osdl.org> escribi?:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
> > 
> > . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
> >   in evaluating the stability, efficacy and relative performance of Nick's
> >   work.
> > 
> >   We're looking for feedback on the subjective behaviour and on the usual
> >   server benchmarks please.
> 
> 
> I must say that this one doesn't feel nice under heavy gcc load. Huge mp3
> skips that didn't happened before, big pauses in X...gcc starves anything else.
> -mm4 was better there.

Can you put your Xserver back to nice -10, and try again?
