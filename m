Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWFIC1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWFIC1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWFIC1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:27:38 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:59485 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751344AbWFIC1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:27:37 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] ANNOUNCE: Linux UWB and Wireless USB project
Date: Thu, 8 Jun 2006 19:27:33 -0700
User-Agent: KMail/1.7.1
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "Pavel Machek" <pavel@ucw.cz>,
       "Inaky Perez-Gonzalez" <inaky@linux.intel.com>,
       linux-kernel@vger.kernel.org
References: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081927.34363.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 1:31 pm, Perez-Gonzalez, Inaky wrote:
> >From: Pavel Machek [mailto:pavel@ucw.cz]
> >
> >Is there any hardware available?
> 
> I think some companies are starting to make PDKs available this
> summer, but YMMV.

Actually ISTR the WUSB team at www.usb.org had press releases talking
about rather bulky PDK + radio kits last winter.  Since then I think
I've heard about at least four teams working on Real Silicon (and I'm
not in those loops at all, so I believe there must be others).

At one point I saw diagrams showing UWB as the platform over which
USB, Bluetooth, Firewire, and network peripheral models would get
layered.  Home mesh networking, anyone?

The notion of authenticating peripherals to Linux will take a bit of
getting used to, I expect ... that's part of the wireless USB model.
RSA and private key management will be getting a bit of a workout...

- Dave
