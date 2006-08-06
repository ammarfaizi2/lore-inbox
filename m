Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWHFWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHFWpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWHFWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:45:31 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:9368 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750751AbWHFWpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:45:30 -0400
Message-ID: <44D67109.6020605@vmware.com>
Date: Sun, 06 Aug 2006 15:45:29 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com> <44D24236.305@vmware.com> <20060805104507.GA4506@ucw.cz>
In-Reply-To: <20060805104507.GA4506@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> ...it should be very easy to opensource simple 'something' layer. If
> it is so complex it is 'hard' to opensource, it is missdesigned,
> anyway... so fix the design.
>   

It's not a design issue - it's a legal issue at this point, and one that 
I'm not qualified to come up with a good answer for.  The biggest 
technical issue I think for open sourcing the VMI, is that it is not 
part of the kernel, but stand alone firmware with a rather bizarre build 
environment, so the code alone is not sufficient to allow it to be open 
sourced, but this is not a hard problem to solve.

Zach
