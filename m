Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267484AbUHJPwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUHJPwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUHJPwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:52:42 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:24718 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S267474AbUHJPsU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:48:20 -0400
X-Sender-Authentication: net64
Date: Tue, 10 Aug 2004 17:48:14 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       diablod3@gmail.com, dwmw2@infradead.org, eric@lammerts.org,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040810174814.414c8fdd.skraw@ithnet.com>
In-Reply-To: <20040810152458.GA1127@lug-owl.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de>
	<20040810164947.7f363529.skraw@ithnet.com>
	<20040810152458.GA1127@lug-owl.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 17:24:59 +0200
Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

> IIRC Jörg complained some hundred emails ago that they (the SuSE people)
> don't care to try to get their patches upstream, back to Jörg, or
> discussing their changes with him (but instead hacking cdrecord the way
> it fits best for them).

Have you followed this thread? I can very well imagine what kind of a mess it
may be to get a patch accepted "upstream".
In fact I would have dropped this idea, too.
 
> While they (and any other distro's people and anybody else) may actually
> hack the code to no end, I consider it being good habit to actually
> *avoid* forking without the intent to (constantly) work in re-merging
> the fork. While this is perfectly legal, I can understand that Jörg
> (even while using a broken email client 8-)  doesn't like getting
> complains about a hacked cdrecord, or missing useful changes the
> distribution people did to cdrecord...

Sometimes forking is unavoidable and necessary. On Joergs side things are
pretty easy. All he has to tell the people is that according to the version
spec they sent he refuses to help them, because they use a forked version.
The true story behind may be that nobody wants to use his version for certain
pecularities and that therefore merely no feedback is reaching him (any more).
 
> So what's commercial distro's primary goal?  (1) Re-packaging
> software for the sole purpose of earning some $$ or  (2) acting as
> a mediator between upstream authors and their paying customers?
> 
> If it is all about (1), I for one would consider (at least for my future
> work) to not continue without actually *forcing* vendors into discussing
> their useful changes with me as an upstream author. Like working IN but
> not solely FOR a community...

Don't try to press politics onto distros. See what they really are: companies.
All companies want to earn bucks, that's what they are for.
If you don't like that, use debian. You got the choice, that's the fine part
about it.

Regards,
Stephan

