Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267192AbSLECed>; Wed, 4 Dec 2002 21:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSLECec>; Wed, 4 Dec 2002 21:34:32 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:25057 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267190AbSLECea>; Wed, 4 Dec 2002 21:34:30 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: mbm@mort.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
References: <9633612287A@vcnet.vc.cvut.cz>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 11:41:51 +0900
In-Reply-To: <9633612287A@vcnet.vc.cvut.cz>
Message-ID: <buoptshrxu8.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
> And because of I was not able to find anything in POSIX which would say
> that we should do split on spaces (not that I found that we should not), 
> I vote for leaving current behavior in Linux, and fixing perl manpage 
> (and eventually FreeBSD, if anyone is interested) instead.

Indeed.

Whatever linux does, that usage remains massively unportable, so the man
page should be changed regardless.

-Miles
-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
