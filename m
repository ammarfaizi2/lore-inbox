Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUFGOsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUFGOsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUFGOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:48:54 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:42880 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264727AbUFGOsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:48:52 -0400
Date: Mon, 7 Jun 2004 16:48:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607144841.GD1467@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <20040607140511.GA1467@elf.ucw.cz> <40C47B94.6040408@scienion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C47B94.6040408@scienion.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Yes, that's pretty much what I meant. ACPI has ~5 people actively
> >working on it, some of them probably full-time. That's a lot of
> >manpower, compared to APM.
> 
> 
>   This becomes a little bit scary. Someone else on this list already
>  mentioned that there is a strong movement towards everything which
>  is at least a desktop/server machine. And on the other hand there are
>  these embedded systems which seem to be attractive for linux to.
> 
>  ACPI seems to be nifty for such things like hardware monitoring and
>  stuff. That makes it interesting for servers etc...
> 
>  Everything in the middle (aka laptops) seems to slowly drop out of the
>  loop. PCMCIA seems to be another ugly example. Anyway ...  I'm not 
>  frightened

HP sells compaq nx5000 notebooks with Linux preloaded. Unfortunately
suspend-to-RAM is not there (IIRC). That's because suspend-to-RAM is
hard to do with ACPI.

PCMCIA... well, that's another obsolete technology. Too bad. 

They are people who care about notebooks, there's just no one that
cares about *old* notebooks any more.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
