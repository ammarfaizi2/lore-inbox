Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752650AbWKBFVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbWKBFVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbWKBFVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:21:10 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50853 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752650AbWKBFVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:21:07 -0500
Message-ID: <4549803D.5020302@pobox.com>
Date: Thu, 02 Nov 2006 00:21:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: How about current IP100A status? 10/31/2006
References: <002101c6fe3e$369ca1e0$4964a8c0@icplus.com.tw>
In-Reply-To: <002101c6fe3e$369ca1e0$4964a8c0@icplus.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> Dear All:
> 
> How about current IP100A, sundance.c status? Should it be put into kernel or
> not?
> Is there any sentence should I need to modify?

It's in my queue.  We are in a bug fix-only cycle right now, so it has
been a bit lower priority, but I will queue it for 2.6.20.

	Jeff



