Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDIVvU>; Tue, 9 Apr 2002 17:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311756AbSDIVvT>; Tue, 9 Apr 2002 17:51:19 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:13706 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S311752AbSDIVvT>; Tue, 9 Apr 2002 17:51:19 -0400
Message-ID: <018201c1e010$a5fc52c0$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "T. A." <tkhoadfdsaf@hotmail.com>, <root@chaos.analogic.com>,
        "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Kurt Wall" <kwall@kurtwerks.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020409075919.4157A-100000@chaos.analogic.com> <OE76STdsxAedIkuHZNp0000992f@hotmail.com>
Subject: Re: C++ and the kernel
Date: Tue, 9 Apr 2002 14:51:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "T. A." <tkhoadfdsaf@hotmail.com>

>     Who the heck said anything about rewriting the kernel?  I'm just looking
> into coding a C++ framework for those whom may like to use it in modules,
> mostly for hack value.

May I humbly suggest that this list is not a good place for this discussion.
Attitudes are quite ossified for many good reasons and probably a few bad
reasons. Take a reasonably cleanly functioning kernel as a tool and develop
a fully C++ kernel. Try it out. Benchmark it for size and speed. Report back
comparisons with its original base.

You are sounding like a little boy who has found a new toy. Over 40 years of
experience suggests the proper way to handle this is to let the person have
his head, and in the corporate world some IR&D funds, to develop a project
that uses the idea and report back in detail how it worked out. If it succeeds
the company or group wins. If it fails it managed to stay out of your product
stream, for as sure as the Sun generally rises roughly in the East it WILL
find its way into something as the person's way of finding out for himself if
it works.

This is an issue that has caused this list a significant amount of distraction
over the years. Maybe it would be a really good thing to develop numbers and
data to either support it or shoot it down. The cant of a Computer Science
cirrocumuli often fails when the rubber meets the road. This may and may not
be such. I trust the kernel maintainers' instincts in this regard. Old age
and experience will beat youth and enthusiasm any day in the long run.

So take a team with you, select a dictator or leader or whatever, and simply
make a rigid translation of a kernel snapshot to C++ without adding any new
functionality. Let us all watch the progress, say on SourceForge or the like.
And report back when it is all done. You may be right that it is something
that is worth doing. But, unless you can show in very hard data that there is
a real advantage to C++ in the kernel Linus will simply reject it with the
full support of the rest of his crew.

FWIW, Microsoft does not use C++ in their kernel.
{^_^}

