Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313149AbSC2CH4>; Thu, 28 Mar 2002 21:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313146AbSC2CHr>; Thu, 28 Mar 2002 21:07:47 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:33249 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S313149AbSC2CHd>;
	Thu, 28 Mar 2002 21:07:33 -0500
Date: Fri, 29 Mar 2002 13:06:39 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Cc: Marc Wilson <msw@cox.net>
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org, Marc Wilson <msw@cox.net>
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au> <20020325085053.GB1382@moonkingdom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Message-Id: <1017367599.231295.13364.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:50:53AM -0800, Marc Wilson wrote:

> On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> > Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> > '8305'?  If it doesn't appear, I'll send off my patch.
> 
> Sorry to disappoint you:
> 
> $ sudo lspci -n | grep 8305
> 00:01.0 Class 0604: 1106:8305
> 
> It's an Abit KT7A-RAID, which is a KT133A.
> 
> Having said that, I've been seeing odd video artifacts in xawtv windows
> since the patch was expanded from merely clearing bit 7. :)

What kind of video card do you have?


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
