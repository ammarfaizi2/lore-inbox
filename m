Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFMNtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFMNtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWFMNtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:49:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43675 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751109AbWFMNtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:49:46 -0400
Message-ID: <448EC273.1050206@sgi.com>
Date: Tue, 13 Jun 2006 08:49:39 -0500
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stack overflow checking for x86_64 / 2.6
References: <448DB363.6060102@sgi.com> <200606130906.17618.ak@suse.de>
In-Reply-To: <200606130906.17618.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Index: linux-2.6.16/arch/x86_64/Kconfig.debug
>> ===================================================================
>> --- linux-2.6.16.orig/arch/x86_64/Kconfig.debug	2006-03-19 23:53:29.000000000 -0600
>> +++ linux-2.6.16/arch/x86_64/Kconfig.debug	2006-06-09 16:15:58.991377500 -0500
> 
> 2.6.16? Of course the patch doesn't apply ... 
> 
> Patch submissions please always against current Linus tree.
> 
> -Andi

It was 2.6.17-rc6, just didn't rename the directory.

Appears my mailer mangled whitespace, I'll resubmit shortly, sorry about that.

-Eric
