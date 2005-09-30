Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVI3A3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVI3A3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVI3A3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:29:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63882
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932411AbVI3A3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:29:39 -0400
Date: Thu, 29 Sep 2005 17:29:24 -0700 (PDT)
Message-Id: <20050929.172924.06476420.davem@davemloft.net>
To: kuznet@ms2.inr.ac.ru
Cc: lists@limebrokerage.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org, gautran@mrv.com
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent
 2.4.x/2.6.x kernels
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050929151729.GA2158@ms2.inr.ac.ru>
References: <20050902183656.GA16537@yakov.inr.ac.ru>
	<Pine.LNX.4.61.0509281223560.30951@ionlinux.tower-research.com>
	<20050929151729.GA2158@ms2.inr.ac.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Date: Thu, 29 Sep 2005 19:17:29 +0400

> Good. I think the patch is to be applied to all mainstream kernels.

Done, thanks everyone.
