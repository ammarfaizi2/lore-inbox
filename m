Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTKHRzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTKHRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:55:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261929AbTKHRzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:55:40 -0500
Message-ID: <3FAD2E04.3020800@pobox.com>
Date: Sat, 08 Nov 2003 12:55:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] forcedeth
References: <3FAC837F.2070601@gmx.net> <20031108085415.C18856@infradead.org>
In-Reply-To: <20031108085415.C18856@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Nov 08, 2003 at 06:47:43AM +0100, Carl-Daniel Hailfinger wrote:
> 
>>Attached is forcedeth: A new driver for the ethernet interface of the
>>NVIDIA nForce chipset, licensed under GPL.
> 
> 
> Any chance to give the driver a more descriptive name, say nforce_eth?
> Traditionally we tend to name like drivers after the hardware's name or
> codename, not the development methology used.


I agree with you on this -- but -- in this special case, it seems wise 
to avoid using a potential trademark as a filename...

I would prefer to avoid the issue completely, rather have to chase down 
some lawyers and get a definitive answer.

	Jeff



