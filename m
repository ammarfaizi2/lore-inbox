Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283547AbRK3H4x>; Fri, 30 Nov 2001 02:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283548AbRK3H4e>; Fri, 30 Nov 2001 02:56:34 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:52185 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283547AbRK3H43>;
	Fri, 30 Nov 2001 02:56:29 -0500
Date: Fri, 30 Nov 2001 08:56:20 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
Message-Id: <20011130085620.24abaf84.rene.rebe@gmx.net>
In-Reply-To: <20011129215855.C8914@kroah.com>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
	<20011130012752.0fd5380a.rene.rebe@gmx.net>
	<20011129215855.C8914@kroah.com>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001 21:58:55 -0800
Greg KH <greg@kroah.com> wrote:

> On Fri, Nov 30, 2001 at 01:27:52AM +0100, Rene Rebe wrote:
> > 
> > Btw. Thanks for DevFS it really ROCKs!! (Except that USBfs exists
> > and I can not maintain / controll it via the devfsd :-(()
> 
> USBfs?  What's that?  I don't see that in the kernel, yet :)

Hu? 2.4.x:

USB support  ---> Preliminary USB device filesystem

??? !!! - It is normally mounted to /proc/bus/usb ...

(But it is not that great (except it works for using a Canon IXUS
digital camera via gphoto2 ... - but controlling the permissions
really sucks (or I do not know how to do this correctly ... ?)

> thanks,
> 
> greg k-h

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
