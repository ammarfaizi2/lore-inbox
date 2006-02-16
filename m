Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWBPD6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBPD6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWBPD6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:58:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42412 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932252AbWBPD6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:58:16 -0500
Message-ID: <43F3F843.4030303@us.ibm.com>
Date: Wed, 15 Feb 2006 19:57:55 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, drepper@redhat.com
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
References: <20060215151711.GA31569@elte.hu>
In-Reply-To: <20060215151711.GA31569@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> This patchset provides a new (written from scratch) implementation of 
> robust futexes, called "lightweight robust futexes". We believe this new 
> implementation is faster and simpler than the vma-based robust futex 
> solutions presented before, and we'd like this patchset to be adopted in 
> the upstream kernel. This is version 1 of the patchset.


Thanks for such a detailed writeup and clean solution.  Clearly a lot of time 
and effort.  The code was nicely commented and easy to read.

There was a reference in the thread about Ulrich having some robust mutex tests, 
are those (or can they be made) publicly available?

-- 
Darren Hart

