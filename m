Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBMUka>; Tue, 13 Feb 2001 15:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129160AbRBMUkV>; Tue, 13 Feb 2001 15:40:21 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:39430 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129108AbRBMUkJ>; Tue, 13 Feb 2001 15:40:09 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Message-ID: <862569F2.006FADCD.00@smtpnotes.altec.com>
Date: Tue, 13 Feb 2001 14:20:21 -0600
Subject: Re: [LK] Re: lkml subject line
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Mike A. Harris" <mharris@opensourceadvocate.org> wrote:
>What is right:
>
>1) not putting the thing in the subject from the list side
>2) If an end user wants it in the subject, they can set up a mail
>filter to PUT it in the subject.
>
>:0 fwh
>* ^Sender:.*owner-linux-kernel
>| sed -e 's/^Subject: /Subject: [lkml]/'
>:0 A:
>lkml
>
>The above filter should add [lkml] to your subject line.  So why
>try to force it on everyone?

The other lists to which I subscribe (SAG-L and HP3000-L) don't force it on
everyone.  Each subscriber can turn the extra subject tags on or off whenever
they please.  I have them turned on, so the listserver tacks them on each
message that is mailed to me.  People who have this option turned off (the
default) never see them.

>If the above procmail filter doesn't work (untested) let me know
>and I will MAKE it work.  Windows users - tough luck - procmail
>is open source - hire someone to port it...

My employer chose Lotus Notes for our email system.  All incoming messages go to
a Notes server.  In order to read them, I have to run a Notes client to connect
to the server.  As far as I know, there is no way to use another mail reader to
access the Notes email database on the server.  So, although I run Linux on my
laptop, I have to run Notes (under wine) to access my mail.  There is no way to
filter on headers; in fact, the ONLY headers I can see are To, cc, and Subject.
(OK, I can, after opening a message, select "Delivery Information" from a menu,
and then scroll through the other headers in a four line by 50 character window;
but I have to do this for each message, one at a time, after they reach my
inbox.  There's no way to search for text in any of these headers, either.)
Even if I save the messages to disk (by "exporting" them), I still get only
those three headers.

I can sort the list of messages in my inbox by sender or by date, but not by
subject.  So I usually just read everything in FIFO order, without even looking
at the subject, hitting the delete key within a couple of seconds for any
message that doesn't interest me.  After finishing with all the messages, I use
the extra tags in the Subject line to (visually) separate the messages I want to
keep and move them into separate folders for each mailing list.  I always leave
the lkml messages till last, because without the extra tags I have to pay
special attention to keep them separate from my regular (non-mailing-list)
email.

As far as I'm concerned, Notes is a lousy mail client.  Very little can be
configured by the user.  The only option for quoted replies simply appends the
entire message to the bottom of the reply.  (I had to cut and paste your text
and add the ">" characters and the "Mike Harris wrote:" line manually.)  I can't
even set it to automatically forward my mail to my personal email account if I'm
out of town.  That requires a request to a Notes administrator to do it for me,
and I have to ask him to change it back when I return.  Plus, when the mail is
auto-forwarded it is deleted from my Notes inbox, so if the administrator is
slow about turning off auto-forwarding then I don't see any of my business email
at work and have to wait until I can access my personal account from home.

I haven't complained about any of this on the list until now, because I know I'm
in the minority and I don't expect most people to care about my problems.  But
it bothered me seeing the criticism Mike Harrold has gotten for his request.
Not everyone has problems because they're lazy.  Some of us are boxed in by
decisions that are beyond our control.  For my part, if anyone can tell me a
method (that doesn't require Notes administrator assistance) to get my mail,
with headers intact, out of Notes and into elm or pine, I'd be ecstatic.

Wayne


