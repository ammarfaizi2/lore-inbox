Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSILUge>; Thu, 12 Sep 2002 16:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSILUge>; Thu, 12 Sep 2002 16:36:34 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:45785 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317351AbSILUgd>; Thu, 12 Sep 2002 16:36:33 -0400
Date: Thu, 12 Sep 2002 17:41:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Spamcop
In-Reply-To: <20020912211056.J4739@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0209121739200.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Russell King wrote:

> I'd like to bring to peoples attention the idiotic situation going on
> with the RBL list known as spamcop.

> However, the basis under which it has been listed is that spamcop
> received a mailman reponse to a message their tester sent to a valid
> mailing list address.  The mailman response was:
>
> "Subject: Your message to Linux-arm awaits moderator approval"

The same happened with NL.linux.org a while ago.

The basic problem with spamcop is that it ISN'T driven by
tests, but by complaints.

It is an automatic system for handling spam complaints and
will automagically list any system it gets too many complaints
about.  Regardless of whether the complaints are legitimate.

> My advice is: stay FAR away from spamcop.  If you're using spamcop
> on your mail server, remove it now before they cut you off from all
> your mailing lists.

Spamcop is useful as part of a scoring system, but absolutely
unsuitable for outright mail rejection.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

