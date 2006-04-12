Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWDLDST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWDLDST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 23:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWDLDST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 23:18:19 -0400
Received: from rtr.ca ([64.26.128.89]:56012 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751320AbWDLDSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 23:18:18 -0400
Message-ID: <443C716C.1060103@rtr.ca>
Date: Tue, 11 Apr 2006 23:18:04 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Joshua Hudson <joshudson@gmail.com>
Cc: Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>	 <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
In-Reply-To: <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>> OK, simplified rules; if you follow them you should generally be OK:
..
>> 3. Userspace code that uses interfaces that was not exposed to userspace
>> before you change the kernel --> GPL (but don't do it; there's almost
>> always a reason why an interface is not exported to userspace)
>>
>> 4. Userspace code that only uses existing interfaces --> choose
>> license yourself (but of course, GPL would be nice...)

Err.. there is ZERO difference between situations 3 and 4.
Userspace code can be any license one wants, regardless of where
or when or how the syscalls are added to the kernel.

Cheers
