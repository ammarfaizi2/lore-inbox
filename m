Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131882AbRDDTN5>; Wed, 4 Apr 2001 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRDDTNs>; Wed, 4 Apr 2001 15:13:48 -0400
Received: from ns2.cypress.com ([157.95.67.5]:33763 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S131953AbRDDTNi>;
	Wed, 4 Apr 2001 15:13:38 -0400
Message-ID: <3ACB7216.9F12D286@cypress.com>
Date: Wed, 04 Apr 2001 14:12:22 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to
In-Reply-To: <E14kWCc-0000EF-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > David Brownell recently added this check to the usb-ohci driver
> > since noone has gotten information from AMD for the workaround,
> > which is rumored to exist, for this bug.
> >
> > Do any of you have contacts within AMD who might be able to
> > get an explanation of the workaround to David Brownell?
> 
> We are working on that currently via the Red Hat contact.
> 
> > value given varies.  Rereading NDP seems to give a valid value.
> > I am not really clear why we don't simply read the value twice
> > whenever the host-controller is detected to be an AMD-756.
> 
> because we dont know the full scope of the problem yet.

Exactly how many bug reports has this caused?
What kind of problems?

I know I had trouble onece, but it was a CONFIG problem
with the 2.4.2ac series and the extra DEBUG options.

	-Thomas
