Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTHST1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTHST0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:26:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261317AbTHSTZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:25:42 -0400
Date: Tue, 19 Aug 2003 20:37:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308191937.h7JJb2M0000234@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, macro@ds2.pg.gda.pl
Subject: Re: Input issues - key down with no key up
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Etc. Set 3 is a pain. Nobody wants it, except the people who have read
> the spec only and say - look, neat, a single code for a single keystroke.
> Reality is very different.

I totally agree that in 99.9% of cases, Set 2 is a more sensible
choice than Set 3.

On the other hand, a configuration option to only support Set 3, and
not implement all of the work-arounds would shrink the kernel by a few
K, which would be nice.

Also, the keyboard I'm using requires Set 3 to operate fully, although
as it's quite possible that I am the only person on the planet who
uses this model of keyboard with Linux, that might not be a very valid
argument :-).

John.
