Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWIOUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWIOUI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWIOUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:08:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31467 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751698AbWIOUI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:08:57 -0400
Date: Fri, 15 Sep 2006 22:05:23 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Amy Fong <amy.fong@windriver.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Broadcom PHY support
Message-ID: <20060915200523.GA11360@electric-eye.fr.zoreil.com>
References: <20060915192847.GA25555@lucciola.windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915192847.GA25555@lucciola.windriver.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amy Fong <amy.fong@windriver.com> :
> [PATCH] Add Broadcom PHY support
> 
> This patch adds a driver to support the bcm5421s and bcm5461s PHY

Can you add a Signed-off-by: line, put the return statements on a
line of their own and Cc: netdev@vger.kernel.org, jeff@garzik.org ?

-- 
Ueimor
