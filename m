Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRKWRZ4>; Fri, 23 Nov 2001 12:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRKWRZg>; Fri, 23 Nov 2001 12:25:36 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:45194 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S282176AbRKWRZf>; Fri, 23 Nov 2001 12:25:35 -0500
Date: Fri, 23 Nov 2001 12:25:27 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Flavio Stanchina <flavio.stanchina@tin.it>,
        linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123122527.A13163@alcove.wittsend.com>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011123110505.A27707@alcove.wittsend.com> <Pine.LNX.3.96.1011123102729.32257D-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011123102729.32257D-100000@mandrakesoft.mandrakesoft.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 10:27:45AM -0600, Jeff Garzik wrote:
> On Fri, 23 Nov 2001, Michael H. Warfield wrote:
> > 	Point is that it BROKE some things....  Like "make install" on
> > RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
> > breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> > like you expected it to be.  Not funny.  Just had three freeswan
> > kinstall builds blow up because of that.

> Life is rough...

	Yes, this is true.  Rough enough as it is.  As one of the (minor)
device driver maintainers, I expect to test some of these versions (some
of which may be unexpectedly radioactive) as quick as I can and I keep
backs so my systems can be booted when a new version is unbootable (very
rare now days, thankfully).  This did NOT help that cause.  Making life
MORE difficult is not the way to get people to TEST things.

> 	Jeff

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
