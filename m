Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263509AbTCNViI>; Fri, 14 Mar 2003 16:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263510AbTCNViI>; Fri, 14 Mar 2003 16:38:08 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:10501 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S263509AbTCNViH>;
	Fri, 14 Mar 2003 16:38:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Never ever use word BitKeeper if Larry does not like you
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2003 22:48:55 +0100
In-Reply-To: <20030314184009$69b1@gated-at.bofh.it> (Jeff Garzik's message
 of "Fri, 14 Mar 2003 19:40:09 +0100")
Message-ID: <873clpbovs.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <20030314184009$1b0a@gated-at.bofh.it>
	<20030314184009$54f5@gated-at.bofh.it>
	<20030314184009$6d9e@gated-at.bofh.it>
	<20030314184009$548a@gated-at.bofh.it>
	<20030314184009$69b1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Thus, even to have an open source BK export tool requires that key
> BK algorithms be open sourced.

You can't "open source" algorithms.  Unpatented algorithms are always
free to use.

It's sufficient if somebody looks at the algorithms employed by BK and
documents them in plain English at a very abstract level.  (Reading
your properly licensed copy of the BK source code and writing down
your thoughts can't be illegal, can it?)  Somebody else can go ahead
and implement them, unencumbered by the BK copyright and BK license.

(This is not legal advice, it's just the way it is done in the
industry if you have to reverse-engineer the product of a competitor
for interoperability reasons.)
