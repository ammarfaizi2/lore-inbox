Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278010AbRJIWRf>; Tue, 9 Oct 2001 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278013AbRJIWR0>; Tue, 9 Oct 2001 18:17:26 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:49936 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S278010AbRJIWRI>;
	Tue, 9 Oct 2001 18:17:08 -0400
Date: Tue, 9 Oct 2001 16:17:37 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
Message-ID: <20011009161737.A14175@qcc.sk.ca>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011009211625Z277979-760+22927@vger.kernel.org> <3BC371B2.6010405@interactivesi.com> <1002665547.1543.123.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1002665547.1543.123.camel@phantasy>; from rml@tech9.net on Tue, Oct 09, 2001 at 06:12:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
> 
> It seems that any Athlon (even Durons) work fine in SMP configurations. 

They work, but not "fine".  There are performance issues with
Thunderbird-core Athlons in SMP configurations that may slow them down
somewhat.

> I have heard conflicting reports of what is actually different about the
> MP vs non-MP parts, with points ranging from "the MP parts are just
> certified" to that MP actually has some different internals.  Whatever
> the case, I suppose the difference isn't earth-shattering and mostly
> marketing (ala Intel).

Non-MP Athlons to now have all been Thunderbird (or earlier) cores.  MP
Athlons are Palomino cores.  The new Athlon XP is a Palomino core.  The
Palomino has specific fixes for MP operation (no more slowdowns due to
SMP), and various performance improvements.

If you don't want to fork out the extra cash for the "official" MP
Athlons, at least buy the XP variant.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
