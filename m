Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUIWNNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUIWNNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUIWNNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:13:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17319 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268439AbUIWNN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:13:28 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [profile] 512x Altix timer interrupt livelock fix vs. 2.6.9-rc2-mm2
Date: Thu, 23 Sep 2004 09:12:59 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040923055430.GB9106@holomorphy.com>
In-Reply-To: <20040923055430.GB9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230912.59647.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 23, 2004 1:54 am, William Lee Irwin III wrote:
> amortization factor. In fact, only 19 flushes were observed on a 64x
> Altix over an approximately 10 minute AIM7 run, and 1 flush on a 512x
> Altix over the course of an entire AIM7 run, for truly vast effective
> amortization factors.

Wow!  That's quite an improvement!  Thanks a lot for seeing this through.

Jesse
