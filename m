Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSG1Dga>; Sat, 27 Jul 2002 23:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSG1Dga>; Sat, 27 Jul 2002 23:36:30 -0400
Received: from cambot.suite224.net ([209.176.64.2]:43528 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S318899AbSG1Dg3>;
	Sat, 27 Jul 2002 23:36:29 -0400
Message-ID: <001201c235e9$000d02e0$6ff583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Hans Reiser" <reiser@namesys.com>, "Daniel Mose" <imcol@unicyclist.com>
Cc: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org.gilby.com>,
       <linux-kernel@vger.kernel.org>
References: <20020726160742.GA951@ksu.edu> <20020726190520.GA3192@localhost> <3D41ADD3.9010509@namesys.com> <20020727220826.A31431@unicyclist.com> <3D434CD3.7010807@namesys.com>
Subject: Re: How to start on new db-based FS?
Date: Sat, 27 Jul 2002 23:43:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

I think Daniel is referring to filesystems in general, when he uses "root"

Matthew
----- Original Message -----
From: "Hans Reiser" <reiser@namesys.com>
To: "Daniel Mose" <imcol@unicyclist.com>
Cc: "Jose Luis Domingo Lopez" <linux-kernel@24x7linux.org.gilby.com>;
<linux-kernel@vger.kernel.org>
Sent: Saturday, July 27, 2002 9:45 PM
Subject: Re: How to start on new db-based FS?


> Daniel Mose wrote:
>
> >Hans Reiser wrote:
> >
> >
> >>We would be happy to cooperate with persons interested in implementing
> >>LDAP optimizing plugins for reiser4.
> >>
> >>
> >
> >I'm doing a scan on the web for disk storage layout documentation on
> >different file systems. I have I think, downloaded just about all
> >there is to download on www.namesys.com, but I fail to find anything
> >that does describe the reiserfs storage layout in any detail.
> >Is there such documentation available?
> >I would be very happy for directions to it in this case.
> >
> >Reason? I want to know if the root file system that I my self is
> >about to develop perhaps is already implemented to some extent in
> >any existing root FS:s ?
> >
>
> What is a root filesystem? (I am accustomed to the term as describing
> what the OS uses for storing the semantic layer's root directory).
>
> >No need to re-invent the wheel. =)
> >
> >I now know for sure that neither the JFS or the XFS does work in the
> >same ways as my drafts from reading their on disk storage scheemes.
> >
> >kind regards
> >Daniel Mose.
> >
> >
> >
> >
>
>
> --
> Hans
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

