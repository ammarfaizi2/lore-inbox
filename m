Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946077AbWGPBxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946077AbWGPBxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946078AbWGPBxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:53:13 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:60038 "EHLO
	asav09.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1946077AbWGPBxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:53:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAL82uUSBUA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Nick Martin <nim@nimlabs.org>
Subject: Re: [PATCH] spaceball: increment SPACEBALL_MAX_ID for 4000FLX Lefty
Date: Sat, 15 Jul 2006 21:53:11 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060716012344.GO17043@nimlabs.org>
In-Reply-To: <20060716012344.GO17043@nimlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607152153.11293.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 July 2006 21:23, Nick Martin wrote:
> From: Nick Martin <nim+linux@nimlabs.org>
> 
> Although the Spaceball 4000FLX Lefty is already supported by the
> spaceball driver, it does not register properly due to SPACEBALL_MAX_ID
> being set too low. This patch increments SPACEBALL_MAX_ID such that the
> 4000FLX Lefty is properly recognized. No changes are needed in the
> actual code, this merely allows the existing code to be run for this
> device.
>

Thank you Nick, will apply.

-- 
Dmitry
