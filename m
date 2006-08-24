Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWHXFU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWHXFU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 01:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWHXFU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 01:20:58 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:20163 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1030293AbWHXFU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 01:20:57 -0400
Message-ID: <44ED3723.3090308@nortel.com>
Date: Wed, 23 Aug 2006 23:20:35 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Re: Linux: Why software RAID?
References: <44ED1E41.40606@garzik.org>
In-Reply-To: <44ED1E41.40606@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2006 05:20:39.0431 (UTC) FILETIME=[0994B170:01C6C73D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> But anyway, to help answer the question of hardware vs. software RAID, I 
> wrote up a page:
> 
>     http://linux.yyz.us/why-software-raid.html

Just curious...with these guys 
(http://www.bigfootnetworks.com/KillerOverview.aspx) putting linux on a 
PCI NIC to allow them to bypass Windows' network stack, has anyone ever 
considered doing "hardware" raid by using an embedded cpu running linux 
software RAID, with battery-backed memory?

It would theoretically allow you to remain feature-compatible by 
downloading new kernels to your RAID card.

Chris
