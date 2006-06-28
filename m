Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423252AbWF1KBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423252AbWF1KBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWF1KBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:01:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29417 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423252AbWF1KBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:01:37 -0400
From: Andreas Schwab <schwab@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lukas Jelinek <info@kernel-api.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org>
	<20060627132226.2401598e.rdunlap@xenotime.net>
	<44A1982C.1010008@kernel-api.org>
	<Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com>
X-Yow: Yow!
Date: Wed, 28 Jun 2006 12:01:22 +0200
In-Reply-To: <Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com> (Steven
	Rostedt's message of "Wed, 28 Jun 2006 05:44:40 -0400 (EDT)")
Message-ID: <jesllp8uq5.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> Here's a version that gets rid of a lot of confusing backslashes:
>
> /^\(\s\)*#endif/ {

You can get rid of even more of them.

/^\s*#endif/ {

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
