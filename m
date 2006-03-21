Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWCUAux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWCUAux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWCUAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:50:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12692
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932233AbWCUAuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:50:52 -0500
Date: Mon, 20 Mar 2006 16:50:01 -0800 (PST)
Message-Id: <20060320.165001.116570604.davem@davemloft.net>
To: jmorris@namei.org
Cc: chrisw@sous-sol.org, cxzhang@watson.ibm.com, netdev@axxeo.de,
       ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0603201936030.6749@excalibur.intercode>
References: <20060320213636.GT15997@sorel.sous-sol.org>
	<20060320.152838.68858441.davem@davemloft.net>
	<Pine.LNX.4.64.0603201936030.6749@excalibur.intercode>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@namei.org>
Date: Mon, 20 Mar 2006 19:37:51 -0500 (EST)

> I believe Catherine is away this week, so it's probably best to drop the 
> code and wait till she gets back and we can get it 100% right.

Ok, agreed.

> Sorry, this is my fault, I should have caught this problem.

No worries.
