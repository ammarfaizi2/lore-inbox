Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUJWXKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUJWXKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUJWXKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:10:47 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:56551 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S261331AbUJWXKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:10:38 -0400
Message-ID: <417AE4EA.6070107@bigpond.net.au>
Date: Sun, 24 Oct 2004 09:10:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: Writing linux kernel specification
References: <Pine.LNX.4.44.0410231118570.25612-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0410231118570.25612-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sat, 23 Oct 2004, Karel Kulhavy wrote:
> 
> 
>>3) Is Linux kernel meant to have a specification and just a lack of time
>>   prevented it, or is Linux kernel meant to not have a specification?
>>4) If I produce a specification that is valid, correct and complete enough
>>   to be useful for general public, will it be included on the Linux kernel
>>   homepage http://www.kernel.org under a link "Linux kernel official
>>   specification" upon my request?
> 
> 
> You can write a specification, but I can guarantee you that
> it will be out of date the moment you run your spell checker
> on it.
> 
> Linux kernel development continues at a very high speed, and
> things inside the kernel change all the time.  The only thing
> that's stable is the user space ABI (the system calls), since
> the behaviour of those (mostly) follows POSIX and the Single
> Unix Standard (SUS).

Maybe that (the mostly bit) is what needs to be documented/specified 
i.e. any differences between the Linux user space ABI and those two 
standards.  Surely that difference is reasonably stable and having it 
documented in a single place would be useful.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
