Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTKMXdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTKMXdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:33:35 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:39558 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264456AbTKMXde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:33:34 -0500
Date: Thu, 13 Nov 2003 16:33:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc4xx Ports
Message-ID: <20031113163332.G10903@home.com>
References: <3FB411A6.9030608@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3FB411A6.9030608@jonmasters.org>; from jonathan@jonmasters.org on Thu, Nov 13, 2003 at 11:20:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 11:20:06PM +0000, Jon Masters wrote:
> I am working on a 405D port using a base kernel of originally 2.4.20 and
> now 2.4.21 from kernel.org rather than Montavista etc.
> 
> There are several 4xx ports kicking around and each bodges the tlb stuff
> in pgtable.h and elsewhere makes simple fixes to make the stock kernel
> actually work...though there are several different offerings by now.
> Would someone care to share experiences privately about 4xx ports?

You'll probably generate more interest on the linuxppc-embedded list
where this stuff is discussed.

-Matt
