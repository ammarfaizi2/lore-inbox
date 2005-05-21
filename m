Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVEUHzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVEUHzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 03:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEUHzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 03:55:40 -0400
Received: from holomorphy.com ([66.93.40.71]:13461 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261697AbVEUHzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 03:55:35 -0400
Date: Sat, 21 May 2005 00:52:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
Message-ID: <20050521075223.GE2057@holomorphy.com>
References: <20050521001925.GQ5112@stusta.de> <20050521012505.GD2057@holomorphy.com> <20050521074110.GS5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521074110.GS5112@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 06:25:05PM -0700, William Lee Irwin III wrote:
>> 9 point releases is nowhere long enough. This removal needs to wait for
>> similar amounts of time as other removed interfaces (c.f. devfs, which
>> is far more offensive).
>> In general there are staging rules for this sort of affair, and although
>> I'm no expert in their fine points, nor can I even say what the exact
>> criteria are, but it's rather clear in this instance it's over the line.
>> I suspect a major release, planned as a staging ground for things like
>> e.g. this and removing devfs, would be the most appropriate time for it.

On Sat, May 21, 2005 at 09:41:10AM +0200, Adrian Bunk wrote:
> The current rules are simply "put it for 6-12 months in 
> Documentation/feature-removal-schedule.txt and remove it then".
> 2.6.3 is more than a year go, and the date when the raw driver was 
> declared obsolete predates the introduction of 
> feature-removal-schedule.txt (at that time, we were still in the belief
> a 2.7 kernel would come some day).

This sounds a little shaky but I'll let someone higher up roll dice or
whatever to decide.


-- wli
