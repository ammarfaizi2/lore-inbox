Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUBKFbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 00:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUBKFbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 00:31:53 -0500
Received: from thunk.org ([140.239.227.29]:59851 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263370AbUBKFbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 00:31:50 -0500
Date: Wed, 11 Feb 2004 00:31:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040211053118.GA2478@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"H. Peter Anvin" <hpa@zytor.com>, Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <1ne1M-1Oc-1@gated-at.bofh.it> <4029364F.9030905@tmr.com> <20040210215225.GA1666@thunk.org> <40295509.1050100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40295509.1050100@zytor.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:02:49PM -0800, H. Peter Anvin wrote:
> The way it looks right now it's not going to matter; it appears that
> (optionally) continuing to supporting BSD ptys will "fall out naturally"
> at least initially.
> 
> Ted, could I ask you to eyeball my patch to see how broken it is?

Sure, send me your latest version of the patch and I'll take a look at it.

						- Ted
