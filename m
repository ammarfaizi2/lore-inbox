Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVB1OZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVB1OZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVB1OWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:22:46 -0500
Received: from gprs215-69.eurotel.cz ([160.218.215.69]:62943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261630AbVB1OWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:22:23 -0500
Date: Mon, 28 Feb 2005 15:17:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050228141705.GA1423@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050226153905.GA8108@localhost.localdomain> <20050227170428.GI1441@elf.ucw.cz> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228135604.GA6364@piper.madduck.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Po 28-02-05 14:56:04, martin f krafft wrote:
> also sprach martin f krafft <madduck@madduck.net> [2005.02.27.1843 +0100]:
> > Please check my first post, if you have the time:
> > 
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=110789536921510&w=2
> 
> There is also
> 
>   http://thread.gmane.org/gmane.linux.acpi.devel/12540
> 
> with the same conclusion.
> 
> Maybe 2.6.11-rcX fixes this.

It was resolved -- modular IDE was the problem. Indeed see the thread above.



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
