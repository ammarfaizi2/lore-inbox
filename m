Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbRA0TQc>; Sat, 27 Jan 2001 14:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130969AbRA0TQV>; Sat, 27 Jan 2001 14:16:21 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:4481 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S130032AbRA0TQO>;
	Sat, 27 Jan 2001 14:16:14 -0500
Message-ID: <3A731E65.8BE87D73@pobox.com>
Date: Sat, 27 Jan 2001 11:15:49 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.com>
CC: David Ford <david@linux.com>, Aaron Lehmann <aaronl@vitelus.com>,
        John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com> <3A7295F6.621BBEC4@Home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the record, the system where I saw the problem
has only ext2 -

jjs

Shawn Starr wrote:

> Yes, I have ReiserFS as well...hrm...
>
> David Ford wrote:
>
> > I can quickly and easily duplicate it on my notebook by playing music or
> > mpegs in xmms.  It may take a few minutes but it's guaranteed.
> >
> > xmms stalls flat on it's face and anything accessing /proc stalls.  If I get
> > the time to do it, I'll take a gander at it with kdb.
> >
> > I have no patches applied to p10, I have reiserfs onboard but I highly doubt
> > it's reiserfs.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
