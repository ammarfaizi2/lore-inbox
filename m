Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCKSW4>; Mon, 11 Mar 2002 13:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSCKSWr>; Mon, 11 Mar 2002 13:22:47 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:58006 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284933AbSCKSWc>; Mon, 11 Mar 2002 13:22:32 -0500
Reply-To: <robertp@ustri.com>
From: "Robert Pfister" <robertp@ustri.com>
To: <linux-kernel@vger.kernel.org>
Subject: VMS File versions (was RE: linux-2.5.4-pre1 - bitkeeper testing)
Date: Mon, 11 Mar 2002 11:22:21 -0700
Message-ID: <033101c1c929$b00f7650$1e00a8c0@nomaam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200203111540.IAA11492@tstac.esa.lanl.gov>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>That is not my recollection.  What I remember is that our system
admistrator
>set up people's accounts so that the default behaviour was as desired by
>the individual.  This has gotten me curious, so I went out to a storage
container
>and dug out an old VAX 4000/60 which hasn't run since about 1992.  If it
works,
>I'll be able to answer with more than vague memories.  At least for VMS
5.1, which
>is just a bit out of date as the current version is 7.3 or so.  Now, if can
just
>remember the SYSTEM password. ;-)

My recollection is that you could set the version limit on a directory, and
this would propogate to all the files underneath, unless you explicitly
changed it.

>Perhaps others whose VMS experience is more recent than mine can answer
this question.
>More generally, if the infrastructure for keeping file versions around is
going
>to be generated for other reasons, having the option to have file versions
could
>be useful for some people.  I certainly remember people who loved that
feature,
>but I wasn't one of them.

I liked file versions when I was doing intense development, and it took a
lot of concentration to keep it all straight. It confused the heck out of
many people, and most sysadmins ran batch jobs to "purge" every night -- so
you could only count on versions being available for a limited time.

Is anyone working on version support for a Linux filesystem, as well as all
the utilities that would need to change?

Robb

