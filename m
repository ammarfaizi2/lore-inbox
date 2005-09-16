Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVIPPMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVIPPMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVIPPMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:12:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19206
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1161088AbVIPPMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:12:15 -0400
Date: Fri, 16 Sep 2005 17:12:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Message-ID: <20050916151226.GR4122@opteron.random>
References: <20050914220334.GF4966@opteron.random> <200509151044.24002.kernel@kolivas.org> <20050915171420.GG4122@opteron.random> <20050916104227.GD14962@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916104227.GD14962@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 08:42:27PM +1000, Anton Blanchard wrote:
> >From memory, if you are using a recent version of dbench it runs for a
> constant amount of time. The old version ran a constant number of

Thanks for the info, it was the recent version, so the bandwidth number
is the important one (and it's a bit higher with the feature enabled,
but it may be just noise).
