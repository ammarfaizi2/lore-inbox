Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUHLCYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUHLCYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268358AbUHLCYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:24:31 -0400
Received: from web13909.mail.yahoo.com ([216.136.172.94]:99 "HELO
	web13909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268353AbUHLCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:24:21 -0400
Message-ID: <20040812022420.58366.qmail@web13909.mail.yahoo.com>
Date: Wed, 11 Aug 2004 19:24:20 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and         others)
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <cone.1092193795.772385.25569.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Con Kolivas <kernel@kolivas.org> wrote:
> 
> Hi
> 
> I tried this on the latest staircase patch (7.I) and am not getting any 
> output from your script when tested up to 60 threads on my hardware. Can you 
> try this version of staircase please?
> 
> There are 7.I patches against 2.6.8-rc4 and 2.6.8-rc4-mm1
> 
> http://ck.kolivas.org/patches/2.6/2.6.8/
> 
> Cheers,
> Con
> 
> 

One thing to note is that I do get a lot of output from the script if I set
interactive to 0 (delays between 3 and 13 seconds with 60 threads).

Nicolas

