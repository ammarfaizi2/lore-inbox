Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVBIXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVBIXbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVBIXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 18:31:32 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36485 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261967AbVBIXbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 18:31:31 -0500
Date: Thu, 10 Feb 2005 00:31:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jon Smirl <jonsmirl@gmail.com>
cc: Nicolas Pitre <nico@cam.org>, Larry McVoy <lm@bitmover.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <9e4733910502091048521ad48d@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502100025240.30794@scrub.home>
References: <20050208155845.GB14505@bitmover.com>  <Pine.LNX.4.61.0502090208580.6118@scrub.home>
  <9e47339105020818242fd9f6fa@mail.gmail.com>  <Pine.LNX.4.61.0502090328490.30794@scrub.home>
  <20050209023928.GB4828@bitmover.com>  <Pine.LNX.4.61.0502090346470.30794@scrub.home>
  <20050209034030.GC4828@bitmover.com>  <Pine.LNX.4.61.0502091128070.7836@localhost.localdomain>
  <9e473391050209093856ce68bd@mail.gmail.com>  <Pine.LNX.4.61.0502091313350.7836@localhost.localdomain>
 <9e4733910502091048521ad48d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Feb 2005, Jon Smirl wrote:

> Larry has said, write up a proposal for changes you want in bk. Send
> it to him for a quote. Come up with the cash and he will do the work.

Here is a simple one: restore the parent information in the gnupatch 
option as they were about a year ago visible in the mails to bk-commits, 
e.g.:
http://marc.theaimsgroup.com/?l=bk-commits-head&m=107558318022033&w=2

Now please go to Larry and see what you get.

bye, Roman
