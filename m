Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVABUln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVABUln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVABUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:37:37 -0500
Received: from holomorphy.com ([207.189.100.168]:41365 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261330AbVABUgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:36:21 -0500
Date: Sun, 2 Jan 2005 12:36:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050102203615.GL29332@holomorphy.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697129508.20050102210332@dns.toxicfilms.tv>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:03:32PM +0100, Maciej Soltysiak wrote:
> I was wondering in the tram today are we close to branching
> off to 2.7
> Do the mighty kernel developers have solid plans, ideas, etc
> to start experimental code

I have a plan to never ever stop experimental code, which is to
actually move on the 2.6.x.y strategy if no one else does and these
kinds of complaints remain persistent and become more widespread.

There is a standard. Breaking things and hoping someone cleans up
later doesn't work. So it has to be stable all the time anyway, and
this is one of the observations upon which the "2.6 forever" theme is
based. Frozen "minimal fix trees" for the benefit of those terrified of
new working code (or alternatively, the astoundingly risk-averse) are a
relatively straightforward theme, which kernel maintainers should be
fully able to faithfully develop.


-- wli
