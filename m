Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWIXWHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWIXWHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIXWHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:07:05 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41405 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751217AbWIXWHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:07:04 -0400
From: Junio C Hamano <junkio@cox.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<20060924124647.GB25666@flint.arm.linux.org.uk>
	<20060924132213.GE11916@pasky.or.cz>
	<20060924142005.GF25666@flint.arm.linux.org.uk>
	<20060924142958.GU13132@pasky.or.cz>
	<20060924144710.GG25666@flint.arm.linux.org.uk>
	<7veju185j9.fsf@assigned-by-dhcp.cox.net>
	<20060924213422.GD12795@flint.arm.linux.org.uk>
Date: Sun, 24 Sep 2006 15:07:03 -0700
In-Reply-To: <20060924213422.GD12795@flint.arm.linux.org.uk> (Russell King's
	message of "Sun, 24 Sep 2006 22:34:22 +0100")
Message-ID: <7veju07wc8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> The problem is that git apply doesn't have a "patch -R" mode - so

I thought Pasky already pointed out that is a misinformation.

