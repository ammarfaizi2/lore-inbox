Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWHRWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWHRWlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWHRWlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:41:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6829 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751553AbWHRWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:41:21 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [08/13]: improve retransmission
	heuristics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <4fa0d3a76693da583d088e5f79f47a2e@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <4fa0d3a76693da583d088e5f79f47a2e@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 00:02:19 +0100
Message-Id: <1155942139.31543.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> 
> Add a dynamic minimum timer for better retransmission behavior.

Acked-by: Alan Cox <alan@redhat.com>

"those who fail to learn from TCP are doomed to re-invent it, badly, at
the wrong level." - Tim Wright

