Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTLEHg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLEHg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:36:26 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:44692 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263893AbTLEHgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:36:25 -0500
Message-ID: <3FD0361F.1030609@stesmi.com>
Date: Fri, 05 Dec 2003 08:39:11 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <3FCF77FF.5814.44720535@localhost>
In-Reply-To: <3FCF77FF.5814.44720535@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> Erik Andersen <andersen@codepoet.org> wrote:
> 
> 
>>On Thu Dec 04, 2003 at 03:50:55PM -0800, Paul Adams wrote:
>>
>>>Unless actual Linux code is incorporated in a binary
>>>distribution
>>>in some form, I don't see how you can claim
>>>infringement of the
>>>copyright on Linux code, at least in the U.S.
>>
>>A kernel module is useless without a Linux kernel in which it can
>>be loaded.  Once loaded, it becomes not merely an adjunct, but an
>>integrat part of the Linux kernel.  Further, it clearly
>>"incorporate[s] a portion of the copyrighted work" since it can
>>only operate within the context of the kernel by utilizing Linux
>>kernel function calls. 
> 
> 
> But what about the case I stated earlier for a driver that is completely 
> binary portable between different operating systems. Hence the low level 
> portion of the driver is not Linux specific at all, and in fact not even 
> designed specifically with Linux in mind. That muddies the waters even 
> more, and even Linus has said he would believe such a driver to be OK.

You mean kind of like a program being compiled by a compiler?

The program isn't designed for a specific platform/cpu/os/whatnot but
when compiled it's specific to a platform/cpu/os/whatnot. With the
"program" being the low level stuff and the extra cruft all compilers
include being the glue.

// Stefan

