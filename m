Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbULRMR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbULRMR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbULRMR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:17:28 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:49925 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S262867AbULRMRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:17:20 -0500
Message-ID: <41C41EA6.2040807@globaledgesoft.com>
Date: Sat, 18 Dec 2004 17:42:22 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Skylar Thompson <skylar@cs.earlham.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What does a dead CPU means in CONFIG_HOTPLUG_CPU
References: <41C3B5D2.70801@globaledgesoft.com> <41C4054D.10105@cs.earlham.edu>
In-Reply-To: <41C4054D.10105@cs.earlham.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much

Skylar Thompson wrote:

> krishna wrote:
>
>> Hi all,
>>
>>    Can any one tell what is a  "dead CPU" in CONFIG_HOTPLUG_CPU .
>
>
> It's a CPU that needs to be swapped out while the system is still 
> running. Some high-end systems (Sun SPARCs and IBM POWERs come to 
> mind) don't require a system shutdown to replace a bad CPU.
>
