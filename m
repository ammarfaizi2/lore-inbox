Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933639AbWK0UyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933639AbWK0UyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbWK0UyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:54:06 -0500
Received: from nacho.alt.net ([207.14.113.18]:22474 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S933639AbWK0UyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:54:03 -0500
Date: Mon, 27 Nov 2006 20:54:02 +0000 (GMT)
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH 2.6.19-rc6] sunrpc: fix race condition
In-Reply-To: <Pine.LNX.4.64.0611271900120.10489@nacho.alt.net>
Message-ID: <Pine.LNX.4.64.0611272037420.24703@nacho.alt.net>
References: <Pine.LNX.4.64.0611271900120.10489@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Chris Caputo <ccaputo@alt.net>
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Chris Caputo wrote:
> From: Chris Caputo <ccaputo@alt.net>
> [PATCH 2.6.19-rc6] sunrpc: fix race condition

Turns out my patch is buggy.  Don't use it.

Chris
