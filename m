Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVHPSkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVHPSkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVHPSkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:40:10 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:23780
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1030291AbVHPSkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:40:08 -0400
Date: Tue, 16 Aug 2005 11:39:43 -0700 (PDT)
Message-Id: <20050816.113943.50223928.davem@davemloft.net>
To: kern@sibbald.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508161638.15129.kern@sibbald.com>
References: <200508161519.39719.kern@sibbald.com>
	<1124200991.17555.33.camel@localhost.localdomain>
	<200508161638.15129.kern@sibbald.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kern Sibbald <kern@sibbald.com>
Date: Tue, 16 Aug 2005 16:38:14 +0200

> Someone is setting nonblocking on my socket !

Glad that's resolved...
