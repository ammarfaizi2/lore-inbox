Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUIXJko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUIXJko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUIXJkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:40:43 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56448 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S268637AbUIXJkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:40:41 -0400
Date: Fri, 24 Sep 2004 11:40:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Hans-Frieder Vogt <hfvogt@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.9-rc2-mm1] i8042 ACPI enumeration update
Message-ID: <20040924094017.GD2575@ucw.cz>
References: <200409211352.22318.bjorn.helgaas@hp.com> <20040922050921.GB4532@ucw.cz> <200409220919.24474.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409220919.24474.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 09:19:24AM -0600, Bjorn Helgaas wrote:
> On Tuesday 21 September 2004 11:09 pm, Vojtech Pavlik wrote:
> > Could you send me the complete patch (as opposed to this differential
> > one)? I think it's probably time to include it into the input tree as it
> > seems functional enough. 
> 
> Here it is.  This includes allow-i8042-register-location-override-2.patch
> from the -mm patchset and the differential patch I sent yesterday.
> 
> Attached rather than inline because I haven't figured out how to
> unbreak Kmail-1.7's tab to space conversions.

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
