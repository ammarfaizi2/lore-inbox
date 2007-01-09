Return-Path: <linux-kernel-owner+w=401wt.eu-S1751293AbXAIKdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbXAIKdh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAIKdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:33:37 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33491 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbXAIKdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:33:36 -0500
Message-ID: <45A36F7B.6000600@garzik.org>
Date: Tue, 09 Jan 2007 05:33:31 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Conke Hu <conke.hu@gmail.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add pci class code for SATA (patch updated)
References: <5767b9100701090203v5eeecc53if2600ee78554003e@mail.gmail.com>
In-Reply-To: <5767b9100701090203v5eeecc53if2600ee78554003e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> On 1/8/07, Jeff Garzik <jeff@garzik.org> wrote:
>>  ...
>> The above seems OK to me...
>>
>>         Jeff
>>
> 
> add pci class code for SATA & AHCI, and replace some magic numbers.
> 
> Signed-off-by: Conke Hu <conke.hu@amd.com>

applied manually.  For some reason git-am did not like your patch, but 
after hand-editing, patch(1) snarfed it right up.

	Jeff



