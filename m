Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUGENNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUGENNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUGENNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:13:20 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:34438 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S266073AbUGENMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:12:12 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange DMA timeouts
Date: Mon, 5 Jul 2004 14:11:56 +0100
User-Agent: KMail/1.6
References: <1088958931.3205.8.camel@slaptop> <200407042152.56258.andrew@walrond.org> <1089028708.4759.3.camel@slaptop>
In-Reply-To: <1089028708.4759.3.camel@slaptop>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051411.56812.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes but...

If you try with acpi=off and it works, we then know that the problem is ACPI 
related.

So then you can file a bug report on
	http://bugme.osdl.org/enter_bug.cgi?product=ACPI

and Len and the boys will work with you to fix it.

It won't get fixed otherwise...

Andrew Walrond
