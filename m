Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUKSRcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUKSRcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUKSRcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:32:32 -0500
Received: from p508B653B.dip.t-dialin.net ([80.139.101.59]:60763 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261491AbUKSRca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:32:30 -0500
Date: Fri, 19 Nov 2004 18:32:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2-mm1] fixed PMD_ORDER for MIPS
Message-ID: <20041119173216.GA11705@linux-mips.org>
References: <20041120010805.1fd04cab.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120010805.1fd04cab.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 01:08:05AM +0900, Yoichi Yuasa wrote:

> This patch is fixed PMD_ORDER for MIPS.

We already have this in CVS.
