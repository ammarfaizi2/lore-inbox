Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSAXJUk>; Thu, 24 Jan 2002 04:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSAXJUV>; Thu, 24 Jan 2002 04:20:21 -0500
Received: from ns.suse.de ([213.95.15.193]:47632 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286188AbSAXJUI>;
	Thu, 24 Jan 2002 04:20:08 -0500
Date: Thu, 24 Jan 2002 10:20:02 +0100
From: Dave Jones <davej@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
        Torrey Hoffman <thoffman@arnor.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: depmod problem for 2.5.2-dj4
Message-ID: <20020124102002.B10498@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Vojtech Pavlik <vojtech@suse.cz>,
	David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
	Torrey Hoffman <thoffman@arnor.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com> <20020123094414.D5170@suse.cz> <20020123212435.GB15259@kroah.com> <003701c1a470$86b6bda0$6800000a@brownell.org> <20020124100154.A8622@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020124100154.A8622@suse.cz>; from vojtech@suse.cz on Thu, Jan 24, 2002 at 10:01:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 10:01:54AM +0100, Vojtech Pavlik wrote:
 
 > > What's the story on "driverfs" happening, by the way?  Last I knew, the
 > > PCI bits weren't yet ready.
 > I'm not absolutely sure about the status of the PCI support, but it
 > should be close to working. Anyway, the driverfs infrastructure itself
 > is in place in 2.5, so even if the PCI part wasn't there, still we can
 > convert USB and Input to it.

>From pre4 changelog:
- Patrick Mochel: devicefs updates, add PCI devices into the hierarchy
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
