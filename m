Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUJYMxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUJYMxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUJYMxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:53:55 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:14037 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261787AbUJYMxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:53:51 -0400
Date: Mon, 25 Oct 2004 15:53:47 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9 latencies: scheduler bug?
Message-ID: <20041025125346.GC9917@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041024212618.GA19377@m.safari.iki.fi> <20041025120021.GA9917@m.safari.iki.fi> <417CF50A.6080702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417CF50A.6080702@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:43:54PM +1000, Nick Piggin wrote:
...
> Don't think I've tried rtc_latency test. A quick search didn't turn
> up its source code...

it's in package latencytest-0.42-png.tar.gz
and homepage seems to be http://www.gardena.net/benno/linux/audio/
http://www.gardena.net/benno/linux/latencytest-0.42-png.tar.gz

code hasn't changed since 2001, it seems.
 
> So... stupid question, is rtc_latencytest running with a realtime
> scheduling policy?

yes, it also does mlockall().

-- 
