Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUKORNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUKORNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUKORLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:11:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5055 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261648AbUKORIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:08:25 -0500
Message-ID: <4198E279.5070806@pobox.com>
Date: Mon, 15 Nov 2004 12:08:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [netdrvr] netdev-2.6 queue updated
References: <20041115064609.GA14547@havoc.gtf.org> <20041115074949.GA9481@wiggy.net>
In-Reply-To: <20041115074949.GA9481@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Hi Jeff,
> 
> Previously Jeff Garzik wrote:
> 
>>The most notable thing is the addition of HostAP.
> 
> 
> I was expecting to see that pulled in through the wireless tree; does
> this have any affect on that tree?

It was pulled in through the wireless tree,

	wireless-2.6 -> netdev-2.6 -> -mm -> (eventually) upstream


