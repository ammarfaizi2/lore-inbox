Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVJKEkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJKEkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVJKEkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:40:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25322
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751276AbVJKEkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:40:23 -0400
Date: Mon, 10 Oct 2005 21:40:21 -0700 (PDT)
Message-Id: <20051010.214021.29518148.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tcallawa@redhat.com
Subject: Re: Linux v2.6.14-rc4
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051011042412.GT7992@ftp.linux.org.uk>
References: <20051011034127.GS7992@ftp.linux.org.uk>
	<20051010.205827.122179808.davem@davemloft.net>
	<20051011042412.GT7992@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 11 Oct 2005 05:24:12 +0100

> For sparc32 ioread*/iowrite* are _trivial_.  Look, the only defining
> properties are

I understand, we can implement this in 2.6.15
