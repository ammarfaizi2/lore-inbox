Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLFRqV>; Wed, 6 Dec 2000 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLFRqL>; Wed, 6 Dec 2000 12:46:11 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:7694 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129228AbQLFRqA>; Wed, 6 Dec 2000 12:46:00 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: All INNOMINATE linux-list feeds are now killed...
Date: 6 Dec 2000 17:15:37 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <90ls7p$662$1@enterprise.cistron.net>
In-Reply-To: <Pine.LNX.4.21.0012061126130.18930-100000@duckman.distro.conectiva> <3A2E3FB5.3993FE29@innominate.com>
X-Trace: enterprise.cistron.net 976122937 6338 195.64.65.201 (6 Dec 2000 17:15:37 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A2E3FB5.3993FE29@innominate.com>,
Juri Haberland  <juri.haberland@innominate.com> wrote:
>Rik van Riel wrote:
>> 
>> Could you make it a one-way list this time?
>> These two-way lists always give horrible problems
>> and I would hate to killfile all of innominate ;)
>
>Allright, I think we have choice :-/
>Sorry again...

At ftp://ftp.cistron.nl/pub/people/miquels/software/cistron-m2n-1.36.tar.gz
you'll find some gatewaying software that is unidirectional, yet
bidirectional ;)

It works by marking the groups as moderated. A posting to the group
will be sent by mail to the moderator, which is a script that
checks and rewrites the news message, and sends it to the list.

That way it's almost impossible for loops to get created.

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
