Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTI1Smn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTI1Smn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:42:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:52673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbTI1Smn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:42:43 -0400
Date: Sun, 28 Sep 2003 11:42:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MCA_bus move
In-Reply-To: <20030928170703.GK24824@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0309281141290.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Matthew Wilcox wrote:
> 
> Updated for 2.6.0-test6.

No it isn't.

Your tree is corrupt, and your include/linux/mca.h file does _not_ match 
the one I have.

Also, please make all diffs be "-p1" based.

		Linus

