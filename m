Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263243AbTCSXTE>; Wed, 19 Mar 2003 18:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbTCSXTE>; Wed, 19 Mar 2003 18:19:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32782 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263243AbTCSXTD>; Wed, 19 Mar 2003 18:19:03 -0500
Message-ID: <3E78FD65.1060708@zytor.com>
Date: Wed, 19 Mar 2003 15:29:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Matt Critcher <mcritch@compsci.lyon.edu>
CC: mirrors@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel.org mirrors] Re: Deprecating .gz format on kernel.org
References: <3E78D0DE.307@zytor.com>  <3E78ED9F.2060300@zytor.com> <1048114783.5033.70.camel@tombigbee.neark.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Critcher wrote:
> 
> now, since Nov, here are these same results --
> 
> 
> .bz --  26815  == 52.6%
> .gz --  24206  == 47.4%
> 
> again, i can only assume that these ratios are the fairly close
> throughout the ftp.us mirrors.
> 
> maybe we can watch these ratios for the next year or so and see how it
> changes....
> 

Sounds like a plan.  I have posted the recommendation that if you carry
only one format, please carry .bz2.

	-hpa

