Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272455AbTHJHDp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272457AbTHJHDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:03:45 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:30983 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272455AbTHJHDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:03:44 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3] Hyperthreading gone
References: <87llu2bvxg.fsf@deneb.enyo.de>
	<20030809221706.GA2106@glitch.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 10 Aug 2003 09:03:42 +0200
In-Reply-To: <20030809221706.GA2106@glitch.localdomain> (Greg Norris's
 message of "Sat, 9 Aug 2003 17:17:06 -0500")
Message-ID: <87oeyyc7u9.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> writes:

> Did you select CPU Enumeration Only, or "normal" ACPI?

CPU Enumeration Only.

> If the former, did you specify the "acpismp=force" parameter at
> bootup?

I didn't.  Previous experience (with some 2.5.x versions) indicates
that Linux does not support full ACPI on this machine.  The
documentation suggests that the command line option enables full ACPI,
so I hesitate to do this.
