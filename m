Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263509AbUJ2X2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbUJ2X2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUJ2XVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:21:42 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:30324 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263654AbUJ2XOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:14:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T60oZ9qk2/xZcc3TYvc9bJEoeXot/4mun3E84V8zFEXbmrkNa3Kam7hwftKLA2r3dIC+T/qUcNCwQBYLUsddxaINB/3Am9B5/t1UrT1jG/ELkZjul3GL+uPqdF7o+YoN1VRPalpeHPzE0HN3r8FIZdISxbI7S/gaCaquCoziAiI=
Message-ID: <9e47339104102916141019bd23@mail.gmail.com>
Date: Fri, 29 Oct 2004 19:14:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alexander Stohr <alexander.stohr@gmx.de>
Subject: Re: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?]
Cc: airlied@gmail.com, kendallb@scitechsoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <015101c4bde1$1051bce0$8511050a@alexs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1098806794.6000.7.camel@tara.firmix.at>
	 <015101c4bde1$1051bce0$8511050a@alexs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 19:12:15 +0200, Alexander Stohr
<alexander.stohr@gmx.de> wrote:
> Hi Jon, Hi audience,
> 
> (I just got aware of that discussion because i got that mail CCed
> trough a resend on a general discussion list about software patents.)
> 
> Even if ATI and nVidia, plus maybe even IBM, would sign a well written
> and working agreement between them all, it would not stop anybody else
> out there in the world that is holding patents from inspecting the unveiled
> data and then looking for specific things that might work for pressing out
> some Billion dollars from those companys. Patents do work, but they do
> work mostly for the lawers income, and for companys that have the only
> purpose for getting revenues from a "bought up" patent portfolio. Those
> can be really nastys, even if you are Microsoft you dont like to pull out

The best way to make this work would be to get ATI, nVidia, IBM and
Intel into a room and do a cross licensing deal on the interface
portion of the designs. If the four companies also enter into a mutual
defense pact that will stop any third parties from causing trouble.

On the other hand, this strategy doesn't work if you are currently,
knowingly violating an existing valid patent.

Keeping things secret does nothing to protect you from a patent
infringement suit. All it does is make it a little harder to initially
detect that there are grounds for one. Once someone files suit they
will use the legal process to get all your secret designs anyway.

I also question if keeping interfaces secret is gaining anyone any
advantages over the competitors. Everyone involved possess an
excellent engineering staff capable of easily figuring out what the
other groups are doing. GPUs compete on functional units, chip
processes, parallelism, marketing and manufacturing cost, not on the
device driver programming model.

My belief is that everyone involved would gain from contributing to a
common pool of code for Linux. I don't believe that doing this is
going to alter anyone's market share; but it will make the users a lot
happier and breed goodwill for all involved.

-- 
Jon Smirl
jonsmirl@gmail.com
