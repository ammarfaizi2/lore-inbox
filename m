Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJ2AO6>; Mon, 28 Oct 2002 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJ2AO5>; Mon, 28 Oct 2002 19:14:57 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:54752 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261616AbSJ2AO4>; Mon, 28 Oct 2002 19:14:56 -0500
To: <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 01:20:58 +0100
Message-ID: <87elaanlhx.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<chris@scary.beasts.org> writes:

> On Mon, 28 Oct 2002, Olaf Dietsche wrote:
>
>> If you're careful with giving away capabilities however, this patch
>> can make your system more secure as it is. But this isn't fully
>> explored, so you might achieve the opposite and open new security
>> holes.
>
> Have you checked how glibc handles an executable with filesystem
> capabilities? e.g. can an LD_PRELOAD hack subvert the privileged
> executable?

No, I didn't check. Thanks for this hint, I will look into this.

Regards, Olaf.
