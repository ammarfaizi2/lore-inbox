Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbTGZUNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbTGZUNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:13:53 -0400
Received: from zork.zork.net ([64.81.246.102]:21737 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S269439AbTGZUNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:13:52 -0400
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Tomas Szepe <szepe@pinerecords.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
References: <20030726195722.GB16160@louise.pinerecords.com>
	<200307261621.55553.jeffpc@optonline.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Jeff Sipek <jeffpc@optonline.net>, Tomas Szepe
 <szepe@pinerecords.com>,  Linus Torvalds <torvalds@osdl.org>, lkml
 <linux-kernel@vger.kernel.org>
Date: Sat, 26 Jul 2003 21:28:38 +0100
In-Reply-To: <200307261621.55553.jeffpc@optonline.net> (Jeff Sipek's message
 of "Sat, 26 Jul 2003 16:21:46 -0400")
Message-ID: <6ud6fx118p.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek <jeffpc@optonline.net> writes:

> On Saturday 26 July 2003 15:57, Tomas Szepe wrote:
> <snip>
>> @@ -89,7 +89,7 @@
>>         tristate "Ext3 journalling file system support"
>>         help
>>           This is the journaling version of the Second extended file system
>> -         (often called ext3), the de facto standard Linux file system
>> +         (often called ext2), the de facto standard Linux file system
>
> The journaling version is ext3, not ext2...

But the *second* extended file system is indeed often called ext2.

