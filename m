Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFAJ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFAJ4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVFAJ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:56:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61638 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261169AbVFAJ4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:56:25 -0400
Date: Wed, 1 Jun 2005 11:55:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
Message-ID: <20050601095519.GA2267@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston> <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston> <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston> <20050601081336.GA6693@elf.ucw.cz> <1117614857.19020.32.camel@gaston> <20050601090622.GB6693@elf.ucw.cz> <1117618614.14386.2057.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117618614.14386.2057.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Seems like lots of stuff is going to happen in pm post-2.6.12: I'd
> > like to finally fix pm_message_t, too...
> 
> Speaking of which, how do you want to move forward with the refrigerator
> patches I sent you a while back?

Can you send them again? I'll either comment on them or integrate them
into tree for linus (linux-good).
								Pavel
