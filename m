Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWGSAco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWGSAco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWGSAcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:32:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:690
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932435AbWGSAcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:32:42 -0400
Date: Tue, 18 Jul 2006 17:33:03 -0700 (PDT)
Message-Id: <20060718.173303.76566134.davem@davemloft.net>
To: takis@lumumba.uhasselt.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: allyesconfig building problem
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060718235554.GA30193@lumumba.uhasselt.be>
References: <20060718235554.GA30193@lumumba.uhasselt.be>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Date: Wed, 19 Jul 2006 01:55:54 +0200

> Hi,
> 
> Trying to build Linux 2.6.18-rc2 (82d6897fefca6206bca7153805b4c5359ce97fc4)
> with the allyesconfig configuration gives me the following error
> message:

Well known build failure, even posted earlier today, and is
fixed int he net-2.6 GIT tree.
