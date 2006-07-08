Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWGHOoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWGHOoP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWGHOoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:44:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:48787 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964856AbWGHOoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:44:14 -0400
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<44AD680B.9090603@unsolicited.net> <20060706221747.GA2632@kroah.com>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 16:44:08 +0200
In-Reply-To: <20060706221747.GA2632@kroah.com>
Message-ID: <p73irm8nolj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> 
> Perhaps, that is odd.  The scanner should default to the logged in user,
> right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> work on it there.

I have a similar problem with my printer. But /dev/usblp0,
/dev/usb/lp0 don't even appear, no matter what the permissions are.

-Andi
