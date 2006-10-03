Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWJCElG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWJCElG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWJCElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:41:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:32171 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965156AbWJCElD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:41:03 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Adrian Bunk <bunk@stusta.de>, linuxppc-dev@ozlabs.org,
       Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1159840091.2349.0.camel@entropy>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	 <20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
	 <1159840091.2349.0.camel@entropy>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:37:40 +1000
Message-Id: <1159850260.5482.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Won't this also cause warnings for valid arch-specific usage (i.e. in
> linux/arch/{i386,x86_64})?

I wouldn't cause that usage valid :)

Ben.


