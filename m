Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUH3WXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUH3WXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUH3WXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:23:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264571AbUH3WXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:23:17 -0400
Message-ID: <4133A8C8.2070205@pobox.com>
Date: Mon, 30 Aug 2004 18:23:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathanael Nerode <neroden@fastmail.fm>
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
References: <20040830221638.GA3596@fastmail.fm>
In-Reply-To: <20040830221638.GA3596@fastmail.fm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathanael Nerode wrote:
> David S. Miller wrote:
> 
>>The tg3 firmware is just a bunch of MIPS instructions.
> 
> Well, good to know that.  It's the first I'd heard of it.

> Much simpler for Broadcom to just release the source code.  :-P


The previous generation of devices, driven by the acenic driver, 
actually had a firmware kit that was available to lucky parties. 
Included full firmware source, that you could tweak to your heart's delight.

	Jeff


