Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUCWCJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCWCJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:09:16 -0500
Received: from holomorphy.com ([207.189.100.168]:43666 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261925AbUCWCJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:09:12 -0500
Date: Mon, 22 Mar 2004 18:09:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040323020907.GU2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, Andrew Morton <akpm@osdl.org>,
	Paul Jackson <pj@sgi.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040322202118.GA27281@tsunami.ccur.com> <20040322231246.GQ2045@holomorphy.com> <20040323001433.GA29320@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323001433.GA29320@tsunami.ccur.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Bugfixes are always good. Maybe the kerneldoc stuff would be a good idea
>> for these functions, and the rest of the non-static functions ppl might
>> be expected to call.

On Mon, Mar 22, 2004 at 07:14:33PM -0500, Joe Korty wrote:
> IMO, one+ liners describing how a function is used is best put near
> the function, where it is most likely to be seen.  Stuff going into
> Documentation/*.txt should be bulky stuff not suitable for inlining,
> such as largish tutorials, annotated examples, theory papers, etc. 

Sorry about not being clear; I meant the : and @ stuff I've seen around
various comments that somehow gets yanked directly out of C comments in
the source and generated into a pdf.


-- wli
