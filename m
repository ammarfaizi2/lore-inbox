Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUE0FNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUE0FNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUE0FNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:13:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30148 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261389AbUE0FNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:13:38 -0400
Message-ID: <40B578F1.3090704@pobox.com>
Date: Thu, 27 May 2004 01:13:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zehetbauer <thomasz@hostmaster.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <1085629714.6583.12.camel@hostmaster.org>
In-Reply-To: <1085629714.6583.12.camel@hostmaster.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:
> I wonder why there is no in-kernel irq balancing for the AMD64
> architecture yet. I guess this shouldn't be much different to the i386
> code. Someone willing to explain/provide a patch?


Why do you think you need in-kernel irq balancing?

Does userspace irqbalanced not work for you?

	Jeff


