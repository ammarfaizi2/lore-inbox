Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTALRxo>; Sun, 12 Jan 2003 12:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTALRxo>; Sun, 12 Jan 2003 12:53:44 -0500
Received: from web21306.mail.yahoo.com ([216.136.129.60]:2473 "HELO
	web21306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267370AbTALRxn>; Sun, 12 Jan 2003 12:53:43 -0500
Message-ID: <20030112180231.84483.qmail@web21306.mail.yahoo.com>
Date: Sun, 12 Jan 2003 10:02:31 -0800 (PST)
From: David Truog <lkml@fienx.net>
Subject: Re: any chance of 2.6.0-test*?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>> I've looked into this, and wow, it's not a simple
fix :(
>> 
>> But this is really the first it's been mentioned, I
can't see holding up
>> 2.6 for this.  It's a 2.7 job at the earliest,
unless someone wants to
>> step up and do it right now...
>
>2.5.x crashes erratically and randomly under high
tty/pty load. At the 
>moment I'm assuming this is the tty code. That means
we can't decide not
>to fix it since its already fatally broken.

Is there a list of things broken and "homeless"?  I
have seen a number of
people say (and do) fix things when they are
specificaly pointed out as
being broken.  if a list doesn't exist, could linus or
alan post one 
somewhere?  like the LKML maintainers list backwards.

just a thought

David Truog

