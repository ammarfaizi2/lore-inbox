Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbUKBTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUKBTtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUKBTtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:49:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261934AbUKBTsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:48:10 -0500
Message-ID: <4187E46D.8020402@pobox.com>
Date: Tue, 02 Nov 2004 14:47:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Starvik <mikael.starvik@axis.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 3/10] CRIS architecture update - Ethernet
References: <BFECAF9E178F144FAEF2BF4CE739C668014C7487@exmail1.se.axis.com>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C7487@exmail1.se.axis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Starvik wrote:
> Update ethernet driver to use generic mii interface.
> 
> Signed-Off-By: starvik@axis.com

overall, looks OK to me.

There are a few places when you indented using spaces, while the 
surrounding code uses tabs for indentation.

	Jeff



