Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283119AbRK2T64>; Thu, 29 Nov 2001 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283127AbRK2T6q>; Thu, 29 Nov 2001 14:58:46 -0500
Received: from hermes.toad.net ([162.33.130.251]:55462 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S283119AbRK2T6d>;
	Thu, 29 Nov 2001 14:58:33 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 14:59:22 -0500
Message-Id: <1007063963.1188.17.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a long shot, but you might try upgrading to
the latest release of apmd, 3.0.2.  You might also
try killing  apmd altogether before suspending;
see what happens.

Does it make any difference if X is not running
when you try to suspend?

Is your BIOS up to date?

Is the only problem the fact that you sometimes have
to press Fn+D to get the suspend to complete?  If so,
that doesn't seem like too big a deal (even if it would
be nice if it were fixed).  Or is the problem more
serious than that?

Thomas

