Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUB0Scq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUB0Scq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:32:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21378 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263098AbUB0ScD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:32:03 -0500
Date: Fri, 27 Feb 2004 13:34:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tim Hockin <thockin@hockin.org>
cc: Grigor Gatchev <grigor@zadnik.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <20040227180516.GA18605@hockin.org>
Message-ID: <Pine.LNX.4.53.0402271323260.8356@chaos>
References: <403E47B4.8080507@matchmail.com>
 <Pine.LNX.4.44.0402271151040.26240-100000@lugburz.zadnik.org>
 <20040227180516.GA18605@hockin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Tim Hockin wrote:

> On Fri, Feb 27, 2004 at 01:18:12PM +0200, Grigor Gatchev wrote:
> > As for directions and adding code: Nobody ever, AFAIK, has intentionally
> > pushed the kernel towards this layered model. And the kernel source is
> > already structured in a way convenient to go with it, and for the last
> > three years was going exactly in this direction! That is why it seems
> > to me that this is the internal logic of the kernel development.
>
> See STREAMS and how well it worked.

This has already been wacked around quite a bit, but the fact remains
that every so-often, some college student (who never worked a day
in her life) or her instructor (who never worked a day in his life)
publish some hair-brained idea that a lot of folks believe must
have some merit because it came from MIT or Berkeley, etc.  Anybody
who's in the IEEE Computer Society can get monthly unworkable or
unusable dissertations from the college community about new ways
to do things. Once every 10 or so years, one of these writings
ends up having some merit. The "layered" model is way too old.
You want to use the new gene-splicing techiques for software
development. Basically, you build a filter that completely
defines the end product required. Then you set the monkeys loose...

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


