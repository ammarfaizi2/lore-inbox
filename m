Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbTLZRiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 12:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbTLZRiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 12:38:54 -0500
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:33409 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S265211AbTLZRiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 12:38:54 -0500
Date: Fri, 26 Dec 2003 19:38:51 +0200
From: Erkki Seppala <flux@modeemi.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ps gets hung before uptime of 3 days persists with 2.6.0
Message-ID: <20031226173851.GA24066@jolt.modeemi.cs.tut.fi>
References: <20031205142834.GA3362@jolt.modeemi.cs.tut.fi> <20031212110509.GA25441@jolt.modeemi.cs.tut.fi> <20031216084244.GA4968@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216084244.GA4968@jolt.modeemi.cs.tut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uptime is 3 days 22 hours, load is 100+ due to hung processes..

My kernel features nick's scheduler patches and i2c-lirc-patches, but
as this problem appeared before patching those on earlier kernels, I
don't think those are to blame.

Earlier messages describe my configuration.
-- 
  _____________________________________________________________________
     / __// /__ ____  __               http://www.modeemi.fi/~flux/\   \
    / /_ / // // /\ \/ /                                            \  /
   /_/  /_/ \___/ /_/\_\@modeemi.fi                                  \/
