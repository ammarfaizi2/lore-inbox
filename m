Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVKLTn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVKLTn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVKLTn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:43:28 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38834
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932479AbVKLTn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:43:27 -0500
Date: Sat, 12 Nov 2005 11:43:28 -0800 (PST)
Message-Id: <20051112.114328.80536354.davem@davemloft.net>
To: imcdnzl@gmail.com
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: Breakage in net/ipv4/tcp_vegas.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <cbec11ac0511121035w3f697824l3d1e3351e229fba4@mail.gmail.com>
References: <200511111336.jABDajMd019962@pincoya.inf.utfsm.cl>
	<cbec11ac0511121035w3f697824l3d1e3351e229fba4@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian McDonald <imcdnzl@gmail.com>
Date: Sun, 13 Nov 2005 07:35:23 +1300

> This has been fixed in the networking tree which I imagine Linus will
> merge again soon but here is the fix before then:
> Recent TCP changes broke the build.

The fix is in Linus's GIT tree and made it into 2.6.15-rc1
as well.

