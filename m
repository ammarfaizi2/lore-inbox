Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWHXWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWHXWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWHXWx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:53:56 -0400
Received: from waste.org ([66.93.16.53]:20621 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030288AbWHXWx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:53:56 -0400
Date: Thu, 24 Aug 2006 17:52:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
Message-ID: <20060824225236.GT19707@waste.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156441295.3014.75.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 07:41:35PM +0200, Arjan van de Ven wrote:
> Subject: [RFC] maximum latency tracking infrastructure
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> The patch below adds infrastructure to track "maximum allowable latency" for power
> saving policies.

Looks good. But it will also be important to have a user-level way to
report who is constraining us from power saving and by how much of a
margin.

-- 
Mathematics is the supreme nostalgia of our time.
