Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSA3JTH>; Wed, 30 Jan 2002 04:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSA3JS5>; Wed, 30 Jan 2002 04:18:57 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:43471 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S288998AbSA3JSg>; Wed, 30 Jan 2002 04:18:36 -0500
From: "Chris Funderburg" <Chris@Funderburg.com>
To: "'Jeff Garzik'" <garzik@havoc.gtf.org>,
        "'Oliver Xymoron'" <oxymoron@waste.org>
Cc: "'Daniel Phillips'" <phillips@bonn-fries.net>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: bug tracking (was Re: A modest proposal -- We need a patch penguin)
Date: Wed, 30 Jan 2002 09:18:15 -0000
Message-ID: <000901c1a96f$13963680$0105360a@bti.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20020130030950.E32317@havoc.gtf.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused.

Wouldn't Bugzilla be perfect for this?  I run a slightly modified
version
for the company I work for.  You could have as many administrators as
you
need, and use categories for different kernel subsystems.  The
maintainers
could be set-up as QA contacts, and it's really easy to maintain.

How about http://bugzilla.kernel.org (assuming the servers get fixed
someday)

Just a thought.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
Sent: 30 January 2002 08:10
To: Oliver Xymoron
Cc: Daniel Phillips; linux-kernel
Subject: bug tracking (was Re: A modest proposal -- We need a patch
penguin)


On Wed, Jan 30, 2002 at 01:41:22AM -0600, Oliver Xymoron wrote:
> The gross fixes tend to get dropped because if they're in, the proper
fix
> loses priority. FIXMEs can take many years to fix. The problem seems
not
> to be the dropping of the patch so much as the dropping of the bug
report
> and bug tracking is an altogether different problem.

Indeed.  The issue of kernel bug tracking gets pondered and discussed
every few months it seems (not without need, mind you).

To tie this back into the original whine from RobL, what we do NOT need
is a patch secretary.  What we do need, desperately, is
(a) a bug-tracking system, and
(b) at least one sharp person, with bunches of help from kernel
developers and users alike, to close fixed bugs, ping users, clear out
garbage so that the bug database has a very high signal-to-noise ratio.

Good kernel bug tracking can be done, but it requires human maintenance,
by someone or someones with a brain.  It cannot be done without plenty
of automation, though, as tytso (god bless him for trying!) showed...

Such would be a significant boon to -all- Linux users.

	Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


