Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTDWWHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTDWWHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:07:42 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:5060 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263591AbTDWWHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:07:41 -0400
Date: Thu, 24 Apr 2003 00:17:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pat Suwalski <pat@suwalski.net>
Cc: Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423221749.GA9187@elf.ucw.cz>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6947D.9080106@suwalski.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I can only guess why. My buest guess is that not all
> >sound-configurations are the same, on some systems the "defaults" could
> >much to loud. (e.g. waking the neigbours when you restart you computer
> >at night)
> 
> This is certainly the case. When I was packaging OSS for Xandros, our 
> initial default was 50 percent. We eventualyl made it about 30, because 
> even that was too loud on a laptop we were testing. There was little 
> coherance between the various soundcards.
> 
> Waking the neighbors is the smallest problem. Blowing a speaker or 
> makign the user deaf if quite another.

Hardware that lets software kill it deserves so, and I believe you
can't make user deaf *that* easily.

I expect kernel to just work, and not need 1001 tools to set it
up. cat /bin/bash > /dev/dsp should produce some noise...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
