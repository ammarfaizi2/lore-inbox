Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265867AbRF2LsI>; Fri, 29 Jun 2001 07:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265866AbRF2Lr6>; Fri, 29 Jun 2001 07:47:58 -0400
Received: from m5-mp1-cvx1b.col.ntl.com ([213.104.72.5]:3712 "EHLO
	[213.104.72.5]") by vger.kernel.org with ESMTP id <S265869AbRF2Lrt>;
	Fri, 29 Jun 2001 07:47:49 -0400
To: Christopher Smith <x@xman.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <3B38860D.8E07353D@kegel.com> <3B38860D.8E07353D@kegel.com>
	<5.1.0.14.0.20010629012013.02a29ac0@imap.xman.org>
From: John Fremlin <vii@users.sourceforge.net>
Date: 29 Jun 2001 12:47:41 +0100
In-Reply-To: <5.1.0.14.0.20010629012013.02a29ac0@imap.xman.org> (Christopher Smith's message of "Fri, 29 Jun 2001 01:22:30 -0700")
Message-ID: <m2d77n8q3m.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Smith <x@xman.org> writes:

[...]

> >Signals are a pretty dopey API anyway - so instead of trying to
> >patch them up, why not think of something better for AIO?
> 
> You assume that this issue only comes up when you're doing AIO. If
> we do something that makes signals work better, we can have a much
> broader impact that just AIO. If nothing else, the signal usage
> clashing issue has nothing to do with AIO.

So what. Signals are bad system already. Therefore don't try to force
them to do more stuff. Just because they have already been forced to
do more doesn't mean it was a good idea at all, or that we should keep
on patching bits and pieces onto them, IMHO.

-- 

	http://ape.n3.net
