Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVANTlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVANTlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVANTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:41:22 -0500
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:62153 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261575AbVANTlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:41:11 -0500
Message-ID: <41E82056.8020609@pantasys.com>
Date: Fri, 14 Jan 2005 11:41:10 -0800
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	<1105707861.6471.1.camel@localhost> <20050114103534.4f4a24be.akpm@osdl.org>
In-Reply-To: <20050114103534.4f4a24be.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2005 19:36:00.0656 (UTC) FILETIME=[46EEE900:01C4FA70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> 
>>i really believe fuse is a good thing to have merged, i use it, and it
>> works really really good.
> 
> 
> What filesystem(s) do you use, and why?

we're currently prototyping a lightweight network filesystem proxy using 
fuse.

peter
