Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282171AbRKWQFa>; Fri, 23 Nov 2001 11:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282172AbRKWQFU>; Fri, 23 Nov 2001 11:05:20 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:36745 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S282171AbRKWQFK>; Fri, 23 Nov 2001 11:05:10 -0500
Date: Fri, 23 Nov 2001 11:05:05 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Flavio Stanchina <flavio.stanchina@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123110505.A27707@alcove.wittsend.com>
Mail-Followup-To: Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20212.1006507727@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain> <20011123094313.GB190@tolot.miese-zwerge.org> <20011123103338.BXVP10632.fep40-svc.tin.it@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123103338.BXVP10632.fep40-svc.tin.it@there>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 11:33:38AM +0100, Flavio Stanchina wrote:
> On Friday 23 November 2001 10:43, Jochen Striepe wrote:
> 
> > I am *much* more irritated by:
> >
> > $ uname -r
> > 2.4.15-greased-turkey

> So I guess you are vegetarian. Try changing to "2.4.15-tasteful-salad".

	Point is that it BROKE some things....  Like "make install" on
RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
like you expected it to be.  Not funny.  Just had three freeswan
kinstall builds blow up because of that.

	Now got to go back and fix it and rebuild.

> -- 
> Ciao,
>     Flavio Stanchina
>     Trento - Italy

> "The best defense against logic is ignorance."
> http://spazioweb.inwind.it/fstanchina/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
