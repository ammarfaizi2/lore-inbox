Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWIVF3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWIVF3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWIVF3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:29:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:24964 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932274AbWIVF3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:29:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aRMj8s9M1qhGl2MNBLDJabLSkIiw++rhoaeqT8DjWlsjW5xE+W9fvNPYzHdRi3qg4x8J7A2NE3WvFtTmV1U4a7r2n8oii4gAROGMeP5hsNAO0kix++QAM6uL5ZveTqchQ2Oi+9Q1NGUjsjCICfVCC+pIytOndzvFFiaa1tZnGyA=
Message-ID: <21d7e9970609212229v1f8f490dx71c6d1abb104400c@mail.gmail.com>
Date: Fri, 22 Sep 2006 15:29:48 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Ryan Richter" <ryan@tau.solarneutrino.net>
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
Cc: "Stephen Olander Waters" <swaters@luy.info>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net, davej@codemonkey.org.uk
In-Reply-To: <20060922051622.GF16939@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158898988.3280.8.camel@ix>
	 <20060922043801.GE16939@tau.solarneutrino.net>
	 <1158900841.3280.12.camel@ix>
	 <20060922051622.GF16939@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Ryan Richter <ryan@tau.solarneutrino.net> wrote:
> On Thu, Sep 21, 2006 at 11:54:01PM -0500, Stephen Olander Waters wrote:
> > Here is the bug I'm working from (includes hardware, software, etc.):
> > https://bugs.freedesktop.org/show_bug.cgi?id=6111
> >
> > DRI will work if you set: Option "BusType" "PCI" ... but that's not a
> > real solution. :)

I really think this more AGP related a bug in the driver for the VIA
AGP chipsets what AGP chipset are you guys using?

Dave.
