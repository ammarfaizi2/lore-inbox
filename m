Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTI2S6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTI2S6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:58:42 -0400
Received: from p508EE58A.dip.t-dialin.net ([80.142.229.138]:17840 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S264459AbTI2S6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:58:40 -0400
Date: Mon, 29 Sep 2003 20:58:34 +0200
From: Patrick Mau <mau@oscar.ping.de>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Message-ID: <20030929185834.GA31748@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
References: <200309282031.54043.MalteSch@gmx.de> <20030928204753.GA28255@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928204753.GA28255@oscar.prima.de>
User-Agent: Mutt/1.5.4i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Malte,

I accidently deleted your original mail. Did you try exporting your
filesystems with "no_subtree_check", like this ?

/dvd \
  tony.local.net(rw,async,no_subtree_check)

If not, could you please try and tell me if that helps ?

Thanks,
Patrick
