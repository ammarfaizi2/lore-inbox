Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSJWMYM>; Wed, 23 Oct 2002 08:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSJWMYL>; Wed, 23 Oct 2002 08:24:11 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53410 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264950AbSJWMYL>; Wed, 23 Oct 2002 08:24:11 -0400
To: bert hubert <ahu@ds9a.nl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: How to decode call trace
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel>
	<p73isztstim.fsf@oldwotan.suse.de>
	<20021023093754.GA28389@outpost.ds9a.nl>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Wed, 23 Oct 2002 14:30:06 +0200
Message-ID: <87isztz6b5.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> On Wed, Oct 23, 2002 at 05:50:41AM +0200, Andi Kleen wrote:
>
>> > Is there a way to get the line number out of these hex values?
>> 
>> addr2line -e vmlinux ... does this when you compile the kernel with -g 
>
> Also interesting is http://ds9a.nl/symoops

This is a real shortcut. Thanks.

Regards, Olaf.
