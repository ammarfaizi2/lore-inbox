Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVKOFY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVKOFY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKOFY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:24:56 -0500
Received: from waste.org ([64.81.244.121]:4313 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751091AbVKOFYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:24:55 -0500
Date: Mon, 14 Nov 2005 21:23:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] netpoll is unable to handle skb's using packet split
Message-ID: <20051115052358.GG31287@waste.org>
References: <9929d2390511141315t2fb15b2aucbbebcbe4cec7ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9929d2390511141315t2fb15b2aucbbebcbe4cec7ef1@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 01:15:38PM -0800, Jeff Kirsher wrote:
> When using packet split, netpoll times out when doing a netdump.

What is "packet split" in this context? You ought to cc: the netdump
people as well, as it's not part of the mainline kernel.

-- 
Mathematics is the supreme nostalgia of our time.
