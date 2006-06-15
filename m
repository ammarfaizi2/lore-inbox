Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031227AbWFOTta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031227AbWFOTta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031228AbWFOTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:49:30 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:23521 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031227AbWFOTt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:49:29 -0400
Message-ID: <4491C7EE.9040303@oracle.com>
Date: Thu, 15 Jun 2006 13:49:50 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] 8250_pnp:  Add support for other Wacom tablets
References: <4491BC77.4040804@oracle.com> <20060615190604.GD8694@flint.arm.linux.org.uk>
In-Reply-To: <20060615190604.GD8694@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Jun 15, 2006 at 01:00:55PM -0700, Randy Dunlap wrote:
>> From: Ben Collins <bcollins@ubuntu.com>
>>
>> [UBUNTU:8250_pnp] Add support for other Wacom tablets that are around
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=6a242b6c279af7805a6cca8f39dbc5bfe1f78cd1
>>
>> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> Is there a way to "pick" this change from that git tree and throw it
> directly into another git tree, preserving all the metadata?
> 

I would expect Yes, but I don't know it...

Maybe git cherry-pick ...

~Randy

