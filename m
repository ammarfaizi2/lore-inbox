Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbVJTDWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbVJTDWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbVJTDWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:22:50 -0400
Received: from tus-gate3.raytheon.com ([199.46.245.232]:32422 "EHLO
	tus-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S1751716AbVJTDWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:22:49 -0400
Message-ID: <43570D85.7060504@raytheon.com>
Date: Wed, 19 Oct 2005 20:22:45 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt9: lpptest removed?
References: <4355DC52.6000202@raytheon.com>
In-Reply-To: <4355DC52.6000202@raytheon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
> 
> When using 'make menuconfig' for 2.6.14-rc4-rt7, the option for:
> 
> Parallel Port Based Latency Measurement Device
> 
> is available (CONFIG_LPPTEST).
> 
> When using 'make menuconfig' for 2.6.14-rc4-rt9, this option doesn't 
> appear to exist.

Duh.  Somehow managed to flip CONFIG_PARPORT between configs.

Apologies.

-- 
Robert Crocombe
rwcrocombe@raytheon.com
