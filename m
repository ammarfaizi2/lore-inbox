Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVKHS4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVKHS4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVKHS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:56:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:1758 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030303AbVKHS4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:56:52 -0500
Message-ID: <4370F4F2.9090903@us.ibm.com>
Date: Tue, 08 Nov 2005 10:56:50 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: [PATCH 0/8] Cleanup slab.c
References: <436FF51D.8080509@us.ibm.com> <Pine.LNX.4.58.0511080956110.10273@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511080956110.10273@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Mon, 7 Nov 2005, Matthew Dobson wrote:
> 
>>Since there was some (albeit very brief) discussion last week about the
>>need to cleanup mm/slab.c, I figured I'd post these patches.  I was
>>inspired to cleanup mm/slab.c since I'm working on a project (to be posted
>>shortly) that touched a bunch of slab code.  I found slab.c to be
>>inconsistent, to say the least.
> 
> 
> Thank you for doing this. Overall, they look good to me except for the 
> bits I commented on. In future, please inline patches to the mail and cc
> Manfred Spraul who more or less maintains mm/slab.c (curiously, I see no
> entry in MAINTAINERS though).
> 
> 			Pekka

As there have been many comments regarding the patches (many more than I
expected! :), I'll resend the whole series later today, and I'll be sure to
cc Manfred.  If he wants, I'll even include a patch to add him to the
MAINTAINERS file...?

-Matt
