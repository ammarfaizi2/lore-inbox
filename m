Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWHBVKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWHBVKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWHBVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:10:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35514
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932161AbWHBVKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:10:54 -0400
Date: Wed, 02 Aug 2006 14:11:03 -0700 (PDT)
Message-Id: <20060802.141103.35507776.davem@davemloft.net>
To: cxzhang@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jmorris@namei.org,
       sds@tycho.nsa.org, catalin.marinas@gmail.com,
       michal.k.k.piotrowski@gmail.com, czhang.us@gmail.com
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec
 patch
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
References: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Catherine you really must begin to remember to add
proper "Signed-off-by: " lines to your patch submissions.

I'll sign off on this bug fix, but in the future I will not
do so for you any more as you've been told at least 3 or 4
times about this.

Thank you.
