Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVIVHPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVIVHPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVIVHPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:15:17 -0400
Received: from [85.8.12.41] ([85.8.12.41]:3459 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750914AbVIVHPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:15:16 -0400
Message-ID: <43325A02.90208@drzeus.cx>
Date: Thu, 22 Sep 2005 09:15:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> <20050921173630.GA2477@localhost.localdomain> <20050921194306.GC13246@flint.arm.linux.org.uk>
In-Reply-To: <20050921194306.GC13246@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>So, before trying to get the "underworked" bug system used more,
>please try to get more developers signed up to it so that we have
>the necessary folk behind the bug system to handle the increased
>work load.
>
>  
>

What we probably need then is an official policy that maintainers need
to have an account in the bugzilla. Start with the subsystem maintainers
and leave it to them to get each driver maintainer in line. Having only
a handful of parts of the kernel in the bugzilla is just confusing.

Personally I think the mailing lists are a great way for general
discussion. But once we have a confirmed bug (or difficult new feature)
it is better off being tracked in bugzilla. And this is my opinion both
as a user and as a developer. Bugzilla is the de facto standard of
reporting bugs so some users might find it troublesome dealing with
mailing lists such as LKML.

Rgds
Pierre
