Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUIWVcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUIWVcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUIWV3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:29:31 -0400
Received: from baikonur.stro.at ([213.239.196.228]:45209 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267417AbUIWVY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:24:59 -0400
Date: Thu, 23 Sep 2004 23:24:56 +0200
From: maximilian attems <janitor@sternwelten.at>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, drizzd@aon.at
Subject: Re: [patch 2/3]  __FUNCTION__ string concatenation
Message-ID: <20040923212456.GE1878@stro.at>
References: <E1CAb35-0005sn-Il@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CAb35-0005sn-Il@sputnik>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, janitor@sternwelten.at wrote:

> 
> 
> I've replaced the __FUNCTION__ string concatenation with the
> %s placeholder and a printf parameter in
> drivers/net/wireless/prism65/islpci_mgt.h, as suggested in the TODO
> list.
> 
> I don't have the hardware to do a run-time check. It should not pose any
> problems though.
> 
argh that one is wrong please forget that single one.

thanks maks

