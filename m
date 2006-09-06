Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIFK5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIFK5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWIFK5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:57:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:45532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750719AbWIFK5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:57:24 -0400
X-Authenticated: #2360897
Date: Wed, 6 Sep 2006 12:57:21 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hrtimers -- high-resolution clock subsystem
Message-ID: <20060906105721.GI4266@mail1.bwalle.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20060905150706.GB14242@mail1.bwalle.de> <1157526843.5714.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157526843.5714.3.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

* Thomas Gleixner <tglx@linutronix.de> [2006-09-06 09:14]:
> On Tue, 2006-09-05 at 17:07 +0200, Bernhard Walle wrote:
> > 
> > ,----[ Documentation/hrtimers.txt]--
> > | We used the high-resolution clock subsystem ontop of hrtimers to
> > | verify the hrtimer implementation details in praxis
> > `----
> > 
> > I didn't find any "high-resolution clock subsystem" in the internet as
> > patch. Can you give me the point or did I got this sentence wrong?
> > Thanks.
> 
> http://www.tglx.de/projects/hrtimers

Ah, sorry, I saw this site but I thought the patches are outdated
because new kernels already include hrtimers. I was wrong and I
applied the patches and it works. :)


Regards,
  Bernhard
