Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWIWQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWIWQeq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWIWQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:34:46 -0400
Received: from colin.muc.de ([193.149.48.1]:13583 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751266AbWIWQep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:34:45 -0400
Date: 23 Sep 2006 18:34:43 +0200
Date: Sat, 23 Sep 2006 18:34:43 +0200
From: Andi Kleen <ak@muc.de>
To: Voluspa <lista1@comhem.se>
Cc: tglx@linutronix.de, mingo@elte.hu, akpm@osdl.org, pavel@suse.cz,
       brugolsky@telemetry-investments.com, linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923163443.GA51112@muc.de>
References: <20060923172517.01ec72b5@loke.fish.not>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923172517.01ec72b5@loke.fish.not>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 05:25:17PM +0200, Voluspa wrote:
> Andi,
> 
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=115897798118500&w=2
> for my original report.
> 
> I've now built without NO_HZ (but still HIGH_RES_TIMERS) and that fixes
> the issue. You've got most of my machine specs since previous, even an
> output from dmidecode, but feel free to ask for more if this bug
> interests you.
> 
> I'm not particularly eager to get it solved... the nvidia driver still
> needs one more hack for the glue to build against -rt3.

-rt* bugs are handled by Ingo and Thomas.

-Andi
