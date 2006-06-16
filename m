Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFPEjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFPEjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 00:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWFPEjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 00:39:24 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:58062 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750749AbWFPEjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 00:39:23 -0400
Message-ID: <4492441E.1020907@oracle.com>
Date: Thu, 15 Jun 2006 22:39:42 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       mb@bu3sch.de, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
References: <44909A3F.4090905@oracle.com> <1150386115.2987.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1150386115.2987.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-06-14 at 16:22 -0700, Randy Dunlap wrote:
>> From: Matthew Garrett <mjg59@srcf.ucam.org>
>>
>> Broadcom wireless patch, PCIE/Mactel support
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc
>>
>> This patch adds support for PCIE cores to the bcm43xx driver. This is
>> needed for wireless to work on the Intel imacs. I've submitted it to
>> bcm43xx upstream.
> 
> 
> who's signing off on these patches??

Well, this particular one isn't going anywhere AFAIK, so it doesn't matter here.
For most of them, Ben Collins or someone else at Ubuntu has signed-off on them
(although not so on this one).

Let's continue the general discussion on the "reviewing" thread.

~Randy


