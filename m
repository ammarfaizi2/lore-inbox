Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSH1LIe>; Wed, 28 Aug 2002 07:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSH1LIe>; Wed, 28 Aug 2002 07:08:34 -0400
Received: from boden.synopsys.com ([204.176.20.19]:13033 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S318780AbSH1LIe>; Wed, 28 Aug 2002 07:08:34 -0400
Date: Wed, 28 Aug 2002 13:12:40 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Georg Demme <gdemme@graphics.cs.uni-sb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Server Hangups
Message-ID: <20020828111240.GC16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Georg Demme <gdemme@graphics.cs.uni-sb.de>,
	linux-kernel@vger.kernel.org
References: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 12:49:15PM +0200, Georg Demme wrote:
> Hello,
> 
> this may not be an kernel issue, but the kernel-mailing-list is
> something like my last resort in solving our problem.
> 
> 
> SYMPTOMS:
> While accessing file/dirs users experience hangups of under one second
> up to several seconds.
> 
> At this point you may think: "Why is this a kernel issue?". Well,
> maybe it is, maybe not. But I am running out of alternatives to
> check (see section TESTS) and people to ask. After 2 MONTHS of tests,
> I am still unable to pin down the problem. So here comes the whole story.
> I hope to reach someone with more experience and am looking forward
> for hints.

syslog, dmesg output would be useful

-alex
