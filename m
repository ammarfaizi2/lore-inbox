Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWDENR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWDENR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWDENR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:17:26 -0400
Received: from smtpout.mac.com ([17.250.248.84]:50125 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751105AbWDENRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:17:25 -0400
In-Reply-To: <200604051206.k35C6Uiq009761@wildsau.enemy.org>
References: <200604051206.k35C6Uiq009761@wildsau.enemy.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0CC157BB-7180-4B94-817A-E96A6099FBA6@mac.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Q on audit, audit-syscall
Date: Wed, 5 Apr 2006 09:17:13 -0400
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2006, at 08:06:30, Herbert Rosmanith wrote:
>> On Wed, Apr 05, 2006 at 01:27:03PM +0200, Herbert Rosmanith wrote:
>>>
>>> good afternoon,
>>>
>>> I'm searching for a way to trace/intercept syscalls, both before  
>>> and after execution. "ptrace" is not an option (you probably know  
>>> why).
>>
>> Does strace do what you are asking for?
>
> as I said, "ptrace" is not an option.

Why not, exactly?  (No, we don't know why).  ptrace is _the_ Linux  
mechanism to trace and intercept syscalls.  There is no other way.

Cheers,
Kyle Moffett

