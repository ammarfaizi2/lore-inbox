Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWAITZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWAITZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWAITZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:25:12 -0500
Received: from waste.org ([64.81.244.121]:20196 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751151AbWAITZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:25:10 -0500
Date: Mon, 9 Jan 2006 13:17:44 -0600
From: Matt Mackall <mpm@selenic.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: get rid of sparse warning
Message-ID: <20060109191743.GJ3356@waste.org>
References: <20060109111507.7aedd31e@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109111507.7aedd31e@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:15:07AM -0800, Stephen Hemminger wrote:
> Get rid of bogus extern attribute that causes sparse warning.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Death to extern!

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
