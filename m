Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVG2DNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVG2DNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVG2DNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:13:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16768 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262063AbVG2DMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:12:31 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
	<m1y87r7sqf.fsf@ebiederm.dsl.xmission.com>
	<20050728074244.GG6529@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Jul 2005 21:12:20 -0600
In-Reply-To: <20050728074244.GG6529@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 28 Jul 2005 09:42:44 +0200")
Message-ID: <m1d5p25mqz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> So unless you are really ambitious I'd like to take
>> device_suspend(PMSG_FREEZE) out of the reboot path for
>> 2.6.13, put in -mm where people can bang on it for a bit
>> and see that it is coming and delay the merge with the stable
>> branch until the bugs with common hardware have been sorted out.
>
> Works for me. I may feel ambitious, but I don't feel like debugging
> every reboot problem or every strange architecture for 2.6.13 :-).

Curses.  Foiled again!

I have failed to pass the buck.

Eric
