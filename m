Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUGMNTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUGMNTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUGMNTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:19:50 -0400
Received: from holomorphy.com ([207.189.100.168]:8341 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265097AbUGMNTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:19:46 -0400
Date: Tue, 13 Jul 2004 06:19:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713131944.GC21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au> <20040713125331.GA21066@holomorphy.com> <40F3DC52.1030308@yahoo.com.au> <20040713130448.GB21066@holomorphy.com> <40F3DF31.3000003@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F3DF31.3000003@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> The semantics I implemented are warning for strictly above the
>> preempt_thresh. Whether those semantics are ideal is irrelevant; it's
>> faithful to those semantics.

On Tue, Jul 13, 2004 at 11:10:09PM +1000, Nick Piggin wrote:
> You are right - I misread it, sorry.

William Lee Irwin III wrote:
>> Given that people are asking for sub-
>> millisecond latencies, maybe I should increase the precision.

On Tue, Jul 13, 2004 at 11:10:09PM +1000, Nick Piggin wrote:
> Would soon be useful I think.

Let me spin up the CONFIG_PREEMPT=n fix and then I'll move on that.


-- wli
