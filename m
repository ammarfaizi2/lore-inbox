Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUG0TcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUG0TcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUG0TcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:32:12 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36873 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266487AbUG0TcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:32:08 -0400
Message-ID: <4106B448.2010308@techsource.com>
Date: Tue, 27 Jul 2004 16:00:08 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Benjamin Rutt <rutt.4+news@osu.edu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: clearing filesystem cache for I/O benchmarks
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org> <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org> <871xixpdky.fsf@osu.edu>
In-Reply-To: <871xixpdky.fsf@osu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Benjamin Rutt wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> 
>>(Please don't remove people from the email recipient list when doing kernel
>>work.)
> 
> 
> Sorry, I'm reading via gmane and my newsreader doesn't make it
> straightforward to do so.  But I'll do it manually for you.


I haven't been paying attention, and I don't know if anyone's already 
suggested this, but going on the title, have you considered running the 
same benchmark more than once and just throwing away the first result?

