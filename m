Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVBJUfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVBJUfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVBJUfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:35:54 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:40714 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261862AbVBJUfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:35:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CBvAgRZIVSAf9YktwXR6gP1yOKXe1+eoV0nciqAtBzAbJ5j598wNj+sVm8zITWWcKoMODJ1yVht+S2JVFB1PT9JCJkQDF4WCFWImWWiJ4wcQLC68uG0MAfptazkc7FCDMQg7hsGuvwD7NyNRrkAYnMH7vlIwW7bm9XLsRBB43BU=
Message-ID: <9e47339105021012341c94c441@mail.gmail.com>
Date: Thu, 10 Feb 2005 15:34:55 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kendall Bennett <kendallb@scitechsoft.com>
In-Reply-To: <1108067388.4085.74.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>
	 <1108066096.4085.69.camel@tyrosine>
	 <9e473391050210121756874a84@mail.gmail.com>
	 <1108067388.4085.74.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added Kendall from Scitech to the CC list. He is the expert on
getting VBIOS's to post. Maybe he can help.

On Thu, 10 Feb 2005 20:29:47 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, 2005-02-10 at 15:17 -0500, Jon Smirl wrote:
> > On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > It also explicitly states that Windows 2000 and XP don't support this,
> > > which leads me to suspect that vendors no longer expect POSTing to be
> > > possible after initial system boot.
> >
> > No, it means that some of my ATI cards don't function as secondary
> > adapters on 2K and XP.
> 
> And nor will any other card that requires POSTing (assuming that it
> isn't just ATI being less than honest about driver shortcomings). And
> we've certainly seen in the past that removing support for functionality
> in Windows tends to result in hardware no longer supporting that
> functionality.
> 
> I have real, shipping hardware here that fails if you simply try to
> execute the video BIOS POST code. If you think this is due to a
> shortcoming in existing BIOS emulations, I'm more than happy to dump the
> video and system BIOS regions and send them to you.
> 
> --
> Matthew Garrett | mjg59@srcf.ucam.org
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
