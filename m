Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVCJE7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVCJE7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVCJEy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:54:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11211 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262383AbVCJExv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:53:51 -0500
Message-ID: <422FD2D6.9050104@ca.ibm.com>
Date: Wed, 09 Mar 2005 22:53:42 -0600
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com> <422FC042.40303@ca.ibm.com> <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>There are certainly sym changes in there too since 2.6.9, let's see if 
>James or Willy have any suggestions. It might not be ppc64-specific.
>
>		Linus
>
>  
>

I have tried with 2.6.10, this appears to fail as well. Unfortunately I 
don't have console access right now so I will have confirm the message 
in the am. I'll start bisecting patches once we confirm.

Omkhar

