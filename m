Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282848AbRLORfz>; Sat, 15 Dec 2001 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282829AbRLORfq>; Sat, 15 Dec 2001 12:35:46 -0500
Received: from pop.gmx.de ([213.165.64.20]:63202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282905AbRLORfh>;
	Sat, 15 Dec 2001 12:35:37 -0500
Date: Sat, 15 Dec 2001 18:35:30 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hangs on num-lock press
Message-Id: <20011215183530.579d14af.rene.rebe@gmx.net>
In-Reply-To: <20011215093012.A19136@kroah.com>
In-Reply-To: <20011215140423.0f8ac337.rene.rebe@gmx.net>
	<20011215093012.A19136@kroah.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001 09:30:12 -0800
Greg KH <greg@kroah.com> wrote:

> On Sat, Dec 15, 2001 at 02:04:23PM +0100, Rene Rebe wrote:
> > Hi all.
> > 
> > I have usb-only system here: MB: sis735; Keyboard: cherry 3000 USB and
> > a Logitech Pilot USB mouse.
> > 
> > When I press num-lock the first time after boot-up or often after switching
> > between X and a VC (Matrox-FB) my system hangs for a second (even sound-
> > stops) and I get this message:
> > 
> > Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(ed)
> > Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(f4)
> 
> What kernel is this?
> What usb host controller driver?
> SMP or UP?

Ups sorry:

2.4.16, usb-ohc, UP (single Athlon).

> thanks,
> 
> greg k-h
> 



k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
