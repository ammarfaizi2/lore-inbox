Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVADTh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVADTh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVADTf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:35:59 -0500
Received: from holomorphy.com ([207.189.100.168]:20362 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261805AbVADTWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:22:00 -0500
Date: Tue, 4 Jan 2005 11:21:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [0/7] LEON SPARC V8 processor support for linux-2.6.10
Message-ID: <20050104192157.GO2708@holomorphy.com>
References: <41DAE87B.8030405@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAE87B.8030405@gaisler.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:03:23PM +0100, Jiri Gaisler wrote:
> I am not sure that the pathes for serial and ethernet drivers
> should be sent to the sparclinux list. If not, please advise on
> where I should submit them.

Jeff Garzik and netdev@oss.sgi.com generally handle network drivers.

Russell King and linux-kernel@vger.kernel.org probably handle
serial drivers considered for inclusion.

I don't have a particularly organized or sophisticated plan for a
staged merging of the drivers. If either should care to absorb the
drivers instead of merely acking them, it's just as well. Both will
generally see anything going across linux-kernel.


-- wli
