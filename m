Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSKFUps>; Wed, 6 Nov 2002 15:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266079AbSKFUps>; Wed, 6 Nov 2002 15:45:48 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:21000 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S266078AbSKFUpr>;
	Wed, 6 Nov 2002 15:45:47 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
References: <20021031163650.GC25906@waste.org>
	<Pine.LNX.4.44.0210310937550.1410-100000@penguin.transmeta.com>
	<20021031180009.GC3620@waste.org>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2002 21:52:25 +0100
In-Reply-To: <20021031180009.GC3620@waste.org> (Oliver Xymoron's message of
 "Thu, 31 Oct 2002 19:10:12 +0100")
Message-ID: <878z065sl2.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> writes:

> - /tmp-style symlink issues on shared directories
> - vast majority of software (including security tools) ACL-unaware
> - much harder to check for correctness

 - surprising inheritance of of the ACL of the directory

This is a known problem in NTFS land, and some people suggest that
per-directory ACLs are enough for everyone for exactly this reason.
