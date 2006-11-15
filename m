Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966674AbWKOEFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966674AbWKOEFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966634AbWKOEFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:05:41 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:18595 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S966506AbWKOEFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:05:39 -0500
Message-ID: <455A9C89.9090802@in.ibm.com>
Date: Wed, 15 Nov 2006 10:20:17 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@au1.ibm.com,
       paulus@samba.org, linuxppc-dev@ozlabs.org, ego@in.ibm.com,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
References: <45586EB5.40409@in.ibm.com>	<1163453995.5940.11.camel@localhost.localdomain>	<4559C6A9.4070204@in.ibm.com> <1163559536.19171.13.camel@localhost.localdomain>
In-Reply-To: <1163559536.19171.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> On Tue, 2006-11-14 at 19:07 +0530, Srinivasa Ds wrote:
>   
>> Hi
>> when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped 
>> in to xmon.
>>     
>
> How did you try to hot plug a cpu? Through sysfs/hmc/somethingelse ?
>   
echo 0 > /sys/devices/system/cpu/cpu1/online
> cheers
>
>   

