Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTG1STt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTG1STt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:19:49 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22407 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270391AbTG1STs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:19:48 -0400
Date: Mon, 28 Jul 2003 20:34:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728183443.GC572@elf.ucw.cz>
References: <20030728181408.GA499@elf.ucw.cz> <20030728182757.GA1793@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728182757.GA1793@win.tue.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Plus I'm seeing some silent data corruption. It may be
> > swsusp or loop related
> 
> Loop is not stable at all. Unsuitable for daily use.

Ouch... I have my most important filesystem on loop. Time to go back
to 2.4.X? Or do you have some patches you want me to try?

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
