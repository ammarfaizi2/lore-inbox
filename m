Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVBJUeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVBJUeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVBJUeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:34:14 -0500
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:61349 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261841AbVBJUcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:32:35 -0500
Date: Thu, 10 Feb 2005 22:32:32 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Bill Davidsen <davidsen@tmr.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050210203232.GA27482@sci.fi>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
	ncunningham@linuxmail.org,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	ACPI List <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1107695583.14847.167.camel@localhost.localdomain> <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi> <1108066096.4085.69.camel@tyrosine> <9e473391050210121756874a84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e473391050210121756874a84@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 03:17:47PM -0500, Jon Smirl wrote:
> On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > It also explicitly states that Windows 2000 and XP don't support this,
> > which leads me to suspect that vendors no longer expect POSTing to be
> > possible after initial system boot.
> 
> No, it means that some of my ATI cards don't function as secondary
> adapters on 2K and XP.

So you can suspend with one of these and the card gets resumed properly? 
If so I wonder why they don't allow POSTing of secondary cards.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
