Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUJWTBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUJWTBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWTBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:01:50 -0400
Received: from florka.hu ([195.70.50.34]:14482 "HELO mail.florka.hu")
	by vger.kernel.org with SMTP id S261276AbUJWTBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:01:45 -0400
Message-ID: <1078.217.232.234.250.1098558101.squirrel@florka.hu>
In-Reply-To: <4179425A.3080903@namesys.com>
References: <20041022032039.730eb226.akpm@osdl.org>
    <4179425A.3080903@namesys.com>
Date: Sat, 23 Oct 2004 21:01:41 +0200 (CEST)
Subject: =?iso-8859-2?Q?Re:=A02.6.9-mm1?=
From: "Hilzinger Marcel" <marcel@hilzinger.hu>
To: "Hans Reiser" <reiser@namesys.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Reiserfs developers mail-list" <reiserfs-dev@namesys.com>,
       "ReiserFS List" <reiserfs-list@namesys.com>
Reply-To: marcel@hilzinger.hu
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton wrote:
>
>>
>>  - reiser4: not sure, really.  The namespace extensions were disabled,
>>    although all the code for that is still present.  Linus's filesystem
>>    criterion used to be "once lots of people are using it, preferably
>> when
>>    vendors are shipping it".  That's a bit of a chicken and egg thing
>> though.
>>    Needs more discussion.
>>
[...]

> I would like to encourage its inclusion as an experimental filesystem
> BEFORE vendors ship it. I think first putting experimental stuff in the
> kernels used by hackers makes sense. I think it creates more of a
> community.
Too late, perhaps... SuSE Linux 9.2 will contain reiser4 (at least the
beta testversions did). It cannot be set up via YaST during installation,
but the tools are there. So anybody, who is curious about reiser4 can test
it without further knowledge.

If SuSE will be as successful with Reiser4, as with ReiserFS, then Reiser4
will first be stable in SuSE Linux, than in the main kernel.

If you do not want this to happen once again, please include it now!

Marcel

