Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWC3QCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWC3QCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWC3QCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:02:55 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:48607 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750783AbWC3QCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:02:54 -0500
Date: Thu, 30 Mar 2006 18:02:52 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
Message-ID: <20060330160252.GA8767@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp> <200603221121.16168.kernel@kolivas.org> <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp> <20060323170413.GA20234@rhlx01.fht-esslingen.de> <871wwtja30.fsf@duaron.myhome.or.jp> <20060330115315.GA15375@rhlx01.fht-esslingen.de> <878xqsrljx.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xqsrljx.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 31, 2006 at 12:37:06AM +0900, OGAWA Hirofumi wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:
> 
> > What further steps should now be taken for this patch to be included
> > in a sufficiently official kernel in some form?
> 
> This patch was included into Linus's tree. Thanks.

Sorry, I totally hadn't expected this to have gone in already, otherwise
I'd certainly have verified that. But indeed the patch seemed quite ok
already...

Oh well, seems Denis Vlasenko (coincidentally quite well-known to me)
now is not the only one having issues with patch status ;)

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
