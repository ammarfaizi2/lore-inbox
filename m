Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUFJJqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUFJJqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUFJJqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:46:08 -0400
Received: from holomorphy.com ([207.189.100.168]:62601 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264571AbUFJJId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:08:33 -0400
Date: Thu, 10 Jun 2004 02:08:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: eric.piel@tremplin-utc.net
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-ID: <20040610090827.GX1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	eric.piel@tremplin-utc.net,
	high-res-timers-discourse@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <20040610024009.GS1444@holomorphy.com> <1086856855.40c81e9743fba@mailetu.utc.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086856855.40c81e9743fba@mailetu.utc.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting William Lee Irwin III <wli@holomorphy.com>:
>> I thought George Anzinger's high resolution timer patches had already
>> been merged? At the very least there's already a kernel/posix-timers.c

On Thu, Jun 10, 2004 at 10:40:55AM +0200, eric.piel@tremplin-utc.net wrote:
> Not exactly, what has been merged is only the POSIX interface of the time=
> rs. The patches to obtain a high resolution (in the order of 10
> microseconds instead of 1ms) are still out from the vanilla kernel.

That sounds useful. Any chance you could post them to lkml for review?
They're significantly less likely to actually be looked at and/or included
if ppl have to chase URL's. (That said, I personally don't have much of an
interest in all this, maybe others will speak up.)

Thanks.


-- wli
