Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWBXQwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBXQwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBXQwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:52:13 -0500
Received: from thunk.org ([69.25.196.29]:38625 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932376AbWBXQwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:52:12 -0500
Date: Fri, 24 Feb 2006 11:52:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gautam H Thaker <gthaker@atl.lmco.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-ID: <20060224165209.GC22097@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Gautam H Thaker <gthaker@atl.lmco.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <43FE134C.6070600@atl.lmco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE134C.6070600@atl.lmco.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:55:56PM -0500, Gautam H Thaker wrote:
> The real-time patches at the URL below do a great job of endowing Linux with
> real-time capabilities.
> 
> http://people.redhat.com/mingo/realtime-preempt/

Gautam,

#1) Can you publish the code you used in your tests?

#2) Can you post your .config file?  In particular, did you have any
of the latency measurement options or other debugging options?  

Regards,

					- Ted
