Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbTGXPZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTGXPZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:25:03 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:46494 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S269379AbTGXPZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:25:01 -0400
Date: Thu, 24 Jul 2003 17:40:02 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: David Zaffiro <davzaffiro@tasking.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using defaults from older kernels
Message-ID: <20030724154002.GA3587@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: David Zaffiro <davzaffiro@tasking.nl>,
	linux-kernel@vger.kernel.org
References: <20030724134929.GJ13611@Synopsys.COM> <3F1FFBCA.8050703@_netscape_._net_>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1FFBCA.8050703@_netscape_._net_>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Zaffiro, Thu, Jul 24, 2003 17:31:22 +0200:
> Why not use `make oldconfig`?

Because it does not make any difference. It will start with the bogus
/boot/config... anyway.

> Alex Riesen wrote:
> >Probably not very good idea.
> >(I decided to retreat to "make defconfig" after it).
> 
