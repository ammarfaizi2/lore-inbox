Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVJAACV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVJAACV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVJAACU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:02:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2953 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030511AbVJAACT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:02:19 -0400
Message-ID: <433DD206.1060802@pobox.com>
Date: Fri, 30 Sep 2005 20:02:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: andrew.patterson@hp.com, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com> <1128105594.10079.109.camel@bluto.andrew> <433D9035.6000504@adaptec.com>
In-Reply-To: <433D9035.6000504@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> But you can write a user space library which uses sysfs or whatever
> _that_ OS uses to represent an SDI spec-ed out picture.
> 
> So a user space program would call (uniformly across all OSs)
> a libsdi library which will use whatever OS dependent way there is
> to get the information (be it sysfs or ioctl).

Agreed completely :)

	Jeff


