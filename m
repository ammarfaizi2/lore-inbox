Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbTCWUWi>; Sun, 23 Mar 2003 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbTCWUWi>; Sun, 23 Mar 2003 15:22:38 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:34057 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S263179AbTCWUWi>;
	Sun, 23 Mar 2003 15:22:38 -0500
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 21:33:31 +0100
In-Reply-To: <20030323202005$2a74@gated-at.bofh.it> (Russell King's message
 of "Sun, 23 Mar 2003 21:20:05 +0100")
Message-ID: <87znnlakmc.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
References: <20030323194012$6886@gated-at.bofh.it>
	<20030323194014$66c3@gated-at.bofh.it>
	<20030323195010$5026@gated-at.bofh.it>
	<20030323195012$6f30@gated-at.bofh.it>
	<20030323200029$737b@gated-at.bofh.it>
	<20030323202005$2a74@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> To give an instance, because I don't work for a distribution, I don't
> have access to the security lists.  Yet, I'm the guy who produces the
> ARM patches which the ARM community at large use.

Well, this is a problem which will be fixed over time.  Amorphous
distributions such as Debian will no longer be notified first, and
non-US distributions will follow if things proceed in the current
direction.  (Look at the handling of the recent IIS vulnerability to
get a glimpse of the future.)
