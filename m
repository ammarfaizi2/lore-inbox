Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTDYJiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTDYJiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:38:13 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:62901 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263522AbTDYJiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:38:12 -0400
Date: Fri, 25 Apr 2003 00:51:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424225103.GC1198@elf.ucw.cz>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423183413.C1425@almesberger.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually, I agree with the submitter. Having the volume default to 0
> > is stupid - userspace tools are all very well, but no substitute for
> > sensible kernel defaults.
> 
> You've obviously never been to a meeting/conference and booted
> a Linux notebook with a kernel that sets things to a non-zero
> default :-)
> 
> If the default is to turn up also the microphone (and to enable
> it in the first place), you might notice that even apparently

So don't enable the microphone unless /dev/dsp is open for reading...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
