Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVAKUAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVAKUAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAKUAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:00:40 -0500
Received: from mail.joq.us ([67.65.12.105]:64931 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261501AbVAKT4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:56:15 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
	<87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org>
	<87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 13:57:11 -0600
In-Reply-To: <20050111195010.GU2940@waste.org> (Matt Mackall's message of
 "Tue, 11 Jan 2005 11:50:10 -0800")
Message-ID: <871xcr3fjc.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Tue, Jan 11, 2005 at 08:30:50AM -0600, Jack O'Quin wrote:
>> "Near-RT" is about the most useless concept I've heard of in a long
>> time.  It sounds like the answer to a question nobody asked.  ;-)
>
> To my way of thinking, it's a pretty good description of Ingo's work
> or anything you're ever going to see on a PC. If you think you're
> going to get real hard RT performance on your off-the-shelf x86 box
> running a conventional OS, you are fooling yourself.
>
> Thankfully a buffer underrun is no more fatal for pro audio than a
> broken guitar string. CDs skip, DATs glitch, XLR cables flake out,
> circuit breakers trip, amps clip, Powerbooks crash, and the show goes
> on. I've done more than enough stage tech to know it's a huge pain in
> the ass, but let's stop pretending we require absolute perfection,
> please.

In _practice_, Ingo's patches are considerably better than what you
seem to consider "good enough for mere audio work".
-- 
  joq
