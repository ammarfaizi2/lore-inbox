Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHVTPa>; Thu, 22 Aug 2002 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSHVTPa>; Thu, 22 Aug 2002 15:15:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18187 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315779AbSHVTPa>; Thu, 22 Aug 2002 15:15:30 -0400
Date: Thu, 22 Aug 2002 20:19:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020822201937.G9153@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0208220009110.3234-100000@hawkeye.luckynet.adm> <E17hwfR-0005A5-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17hwfR-0005A5-00@sites.inka.de>; from ecki-news2002-08@lina.inka.de on Thu, Aug 22, 2002 at 08:26:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 08:26:49PM +0200, Bernd Eckenfels wrote:
> v6 isnt more secure than v4, and i suspect ipsec is more widely used in v4
> than in v6, and i doubt it will ever be used on default.

Remember also that our v6 firewall infrastructure isn't as advanced as
its v4 counterpart.  v6 connection tracking?  sorry, we don't have that.
IMHO v6 firewalling code is currently where the 2.2 kernels are.

(Disclaimer: I'm not going to get into a discussion about the advantages /
disadvantages of connection tracking wrt security.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

