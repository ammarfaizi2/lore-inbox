Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSJWMVJ>; Wed, 23 Oct 2002 08:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSJWMVJ>; Wed, 23 Oct 2002 08:21:09 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:18852 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264938AbSJWMVI>; Wed, 23 Oct 2002 08:21:08 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.5.44: How to decode call trace
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel>
	<p73isztstim.fsf@oldwotan.suse.de> <878z0p1m2y.fsf@goat.bogus.local>
	<20021023124846.L27461@parcelfarce.linux.theplanet.co.uk>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Wed, 23 Oct 2002 14:26:52 +0200
In-Reply-To: <20021023124846.L27461@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Wed, 23 Oct 2002 12:48:46 +0100")
Message-ID: <87of9lz6gj.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> The normal way to do what you want is to edit the Makefile and add -g
> directly to CFLAGS.

Ok, thanks.

Regards, Olaf.
