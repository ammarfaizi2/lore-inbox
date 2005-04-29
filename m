Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVD2AE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVD2AE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVD2AEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:04:25 -0400
Received: from [203.2.177.22] ([203.2.177.22]:14865 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S262345AbVD2AEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:04:22 -0400
Subject: Re: [PATCH] 2.6.11.7  X.25 : x25tap
From: Andrew Hendry <ahendry@tusc.com.au>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050428174309.GP23013@shell0.pdx.osdl.net>
References: <1114576764.4789.36.camel@localhost.localdomain>
	 <20050428174309.GP23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1114733031.3725.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 10:03:51 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2005 00:03:02.0343 (UTC) FILETIME=[CF905570:01C54C4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback.

> Can this not be done with tun/tap?  Ethertap is gone:

I don't think tun/tap itself can do it. I'll look how it works and see
if something similar could do what we need.

Andrew.

