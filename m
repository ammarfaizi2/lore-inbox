Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUKSKVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUKSKVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKSKVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:21:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60570 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261340AbUKSKVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:21:37 -0500
Message-ID: <419DC922.1020809@pobox.com>
Date: Fri, 19 Nov 2004 05:21:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: let x86_64 no longer define X86
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de>
In-Reply-To: <20041119085132.GB26231@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Nov 19, 2004 at 01:51:17AM +0100, Adrian Bunk wrote:
> 
>>I'd like to send a patch after 2.6.10 that removes the following from 
>>arch/x86_64/Kconfig:
>>
>>  config X86
>>        bool
>>        default y
> 
> 
> I'm against this. Please don't do this.

An explanation would be nice.

	Jeff



