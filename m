Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTEOOv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTEOOv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:51:57 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:30352 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264060AbTEOOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:51:55 -0400
Date: Fri, 16 May 2003 01:05:27 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk[89]: software suspend compile error
Message-ID: <20030515150527.GC632@zip.com.au>
References: <20030515144933.GB632@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515144933.GB632@zip.com.au>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 12:49:33AM +1000, CaT wrote:
> tried to see if I could fix this myself but couldn't figure out what was
> happening. the ld line that creates the built-in.o has suspend_asm.o in
> it which, in turn, seems to contain the right labels so I'm a bit lost.
> Anyhow, here's part of the output and the relevant (I hope) bit of the
> .config.

And ofcourse, the message (from another thread) that eventually points
me to the patch that fixes this comes after I send my bug report. Feh.
:)

Ignore this thread. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
