Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbULPXqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbULPXqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbULPXpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:45:04 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:52692 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262196AbULPXnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:43:47 -0500
Message-ID: <41C21DC7.4070007@verizon.net>
Date: Thu, 16 Dec 2004 18:44:07 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] computone: remove unnecessary files from drivers/char/ip2
References: <20041216225431.4074.80006.90928@localhost.localdomain> <20041216231007.GW12937@stusta.de>
In-Reply-To: <20041216231007.GW12937@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Thu, 16 Dec 2004 17:43:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Dec 16, 2004 at 04:54:10PM -0600, james4765@verizon.net wrote:
> 
> 
>>Let me try that one again - this time with the right file (oops :)
>>
>>Remove a makefile and three programs from drivers/char/ip2 - they should not be in the kernel.
>>...
> 
> 
> Why did I think I've seen such a patch before?  ;-)
> 
> I sent the same patch some time ago and it's already in -mm.
> 
> You better send patches against -mm which is already over 17 MB away 
> from -rc3.
> 
> cu
> Adrian
> 

Okay.  I thought I'd remembered seeing that patch a while ago, but couldn't be 
sure.  Guess it's time to go to the bleeding edge - start working off of -mm.

Thanks,

Jim
