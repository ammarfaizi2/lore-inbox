Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTLGKXo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 05:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbTLGKXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 05:23:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:26580 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264397AbTLGKXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 05:23:43 -0500
Date: Sun, 7 Dec 2003 11:21:18 +0100
From: Henning Meier-Geinitz <henning@meier-geinitz.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: Beaver in Detox!)
Message-ID: <20031207102118.GC24676@meier-geinitz.de>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
References: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org> <20031128182625.GP2541@stop.crashing.org> <20031206184901.GH2455@meier-geinitz.de> <20031207044857.GV912@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207044857.GV912@stop.crashing.org>
User-Agent: Mutt/1.5.4i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:ef7bc16c10d3556bf134993d9edc1e24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 06, 2003 at 09:48:57PM -0700, Tom Rini wrote:
> > Does the freeze also happen if no other USB devices are attached? I guess
> > working without a keyboard is not that easy but it may be worth a test.
> 
> I can xhost things to another machine rather easily.  But Greg KH talked
> me into switching to libusb for the scanner, and everything works
> perfectly now.  Do you still want me to give it a go?  Thanks.

If it doesn't happen with libusb it's really most probably a bug in
the scanner driver so you don't need to test. However it's pretty much
uncommon that nobody else sees this problem. I'll mention it on my
website so it's not forgotten.

Thanks,
  Henning
