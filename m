Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbSIPWjt>; Mon, 16 Sep 2002 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSIPWjt>; Mon, 16 Sep 2002 18:39:49 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:23564 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263238AbSIPWjt>; Mon, 16 Sep 2002 18:39:49 -0400
Date: Tue, 17 Sep 2002 00:44:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17r3jV-0005en-00@starship>
Message-ID: <Pine.LNX.4.44.0209170036140.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Sep 2002, Daniel Phillips wrote:

> > Let me explain it in a larger context. You and Daniel are making it really
> > more complex than necessary. Only the module itself can really answer the
> > question whether it's safe to unload or not.
>
> Excuse me, Roman, but that's the central thesis of my [rfc].  If I didn't
> express it concisely enough to make that obvious, I apologize.

Sorry, but even your later mails are not very concise, I rather wait for a
new rfc (preferably with patch) before commenting on it. :-)

bye, Roman

