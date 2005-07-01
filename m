Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVGAULD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVGAULD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVGAULD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:11:03 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:25011 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261364AbVGAUJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:09:50 -0400
Message-ID: <42C5A300.3080101@trex.wsi.edu.pl>
Date: Fri, 01 Jul 2005 22:09:36 +0200
From: =?UTF-8?B?TWljaGHFgiBQaW90cm93c2tp?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Question about patch order
References: <42C59EDD.2080206@mvista.com>
In-Reply-To: <42C59EDD.2080206@mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

George Anzinger wrote:

> Suppose I am doing this prior to my morning coffee, but...
>
> What should the -rc patch(s) be applied to?  Should it be
> 2.6.x or 2.6.x.n
> e.g. the 2.6.12 kernel or the 2.6.12.2 kernel?

Patch is against 2.6.x.

>
> If the former, does the -rc contain the .n stuff?
>
>
Yes. If -rc is newer than .n.

Regards,
Michał Piotrowski
