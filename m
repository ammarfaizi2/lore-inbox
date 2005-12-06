Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVLFLXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVLFLXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVLFLXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:23:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:14805 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751440AbVLFLXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:23:31 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 12:23:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206112329.GF10574@merlin.emma.line.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Bill Davidsen <davidsen@tmr.com>, Ben Collins <bcollins@ubuntu.com>,
	linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <4394C745.2020802@tmr.com> <4394EDDE.30605@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394EDDE.30605@pobox.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Jeff Garzik wrote:

> Bill Davidsen wrote:
> >I do think the old model was better; by holding down major changes for 
> >six months or so after a new even release came out, people had a chance 
> >to polich the stable release, and developers had time to recharge their 
> >batteries so to speak, and to sit and think about what they wanted to 
> >do, without feeling the pressure to write code and submit it right away. 
> >Knowing that there's no place to send code for six months is a great aid 
> >to generating GOOD code.
> 
> It never worked that way, which is why the model changed.
> 
> Like it or not, developers would only focus on one release.  In the old 
> model, unstable things would get shoved into the stable kernel, because 
> people didn't want to wait six months.  And for the unstable kernel, it 
> would often be so horribly broken that even developers couldn't use it 
> for development (think 2.5.x IDE).

So why haven't the broken patches (yes, TCQ and all that, too) been
backed out at the time?

-- 
Matthias Andree
