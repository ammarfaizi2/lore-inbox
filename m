Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGBEYk>; Tue, 2 Jul 2002 00:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGBEYj>; Tue, 2 Jul 2002 00:24:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40633 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316609AbSGBEYj>; Tue, 2 Jul 2002 00:24:39 -0400
Date: Tue, 2 Jul 2002 00:26:29 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Ralph Corderoy <ralph@inputplus.co.uk>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Message-ID: <20020702002629.A22148@devserv.devel.redhat.com>
References: <200207011647.g61GlNx14474@blake.inputplus.co.uk> <200207021416.42616.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207021416.42616.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Tue, Jul 02, 2002 at 02:16:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Brad Hards <bhards@bigpond.net.au>
> Date: Tue, 2 Jul 2002 14:16:42 +1000

> > > I have an idea: remove usbkbd or make it extremely hard for newbies to
> > > build (e.g. drop CONFIG_USB_KBD from config.in, so it would need to be
> > > added manually if you want usbkbd).

> Unfortunately, removal has been vetoed by the USB Maintainer based on
> the code size issue.

Was it during the Randy's, JE's or Greg's reign? Their ideas
about a direction of development were sometimes different.

-- Pete
