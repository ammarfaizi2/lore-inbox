Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTFHHwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 03:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTFHHwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 03:52:44 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61907 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261161AbTFHHwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 03:52:43 -0400
Date: Sun, 8 Jun 2003 10:06:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Pavel Machek <pavel@suse.cz>, dan carpenter <error27@email.com>,
       chris@memtest86.com, linux-kernel@vger.kernel.org
Subject: Re: memtest86 on the opteron
Message-ID: <20030608080606.GB236@elf.ucw.cz>
References: <20030607202725.22992.qmail@email.com> <20030607214356.GF667@elf.ucw.cz> <1055040745.27939.3.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055040745.27939.3.camel@camp4.serpentine.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, as opteron is i386-compatible, you should be able to simply use
> > i386 memtest...
> 
> It doesn't work.  Crashes and reboots the system shortly after it
> starts.  The serial console support appears to have bit-rotted, too, so
> I've not been able to capture an output screen to diagnose the problem.

Try asking AMD at discuss@x86-64.org.

BTW I'm sure I've seen x86_64 machine running some kind of
memtest.... There was mem-testing PCI card. I'm not sure if we ran
memtest86, too...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
