Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUGPQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUGPQZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUGPQZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:25:53 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28158 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266573AbUGPQZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:25:52 -0400
Date: Fri, 16 Jul 2004 09:25:45 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: jamal <hadi@cyberus.ca>
Cc: jgarkzik@pobox.om, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add IXDP2x01 board support to CS89x0 driver
Message-ID: <20040716162545.GA4351@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040716092859.GA16849@plexity.net> <1089983382.1060.1332.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089983382.1060.1332.camel@jzny.localdomain>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16 2004, at 09:09, jamal was caught saying:
> On Fri, 2004-07-16 at 05:28, Deepak Saxena wrote:
> > Jeff,
> > 
> > The following patch modifies the CS89x0 driver to work on Intel's IXDP2401 
> > and IXDP2801 (Intel ARm/XScale based) platforms: 
> > 
> 
> cool. Do you need anything else that is not in the kernel to boot either
> board? 

I have a patch I will be releasing today or monday (see linux-arm-announce 
list) that contains the arm-specific bits. Unfortunately since rmk is 
travelling for about 3 weeks it won't go upstream for atleast that time 
period.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
