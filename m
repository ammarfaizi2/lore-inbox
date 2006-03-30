Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWC3PhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWC3PhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWC3PhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:37:15 -0500
Received: from mail.parknet.jp ([210.171.160.80]:18694 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751074AbWC3PhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:37:14 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
	<87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
	<20060323170413.GA20234@rhlx01.fht-esslingen.de>
	<871wwtja30.fsf@duaron.myhome.or.jp>
	<20060330115315.GA15375@rhlx01.fht-esslingen.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 31 Mar 2006 00:37:06 +0900
In-Reply-To: <20060330115315.GA15375@rhlx01.fht-esslingen.de> (Andreas Mohr's message of "Thu, 30 Mar 2006 13:53:15 +0200")
Message-ID: <878xqsrljx.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:

> What further steps should now be taken for this patch to be included
> in a sufficiently official kernel in some form?

This patch was included into Linus's tree. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
