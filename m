Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLORdP>; Sat, 15 Dec 2001 12:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282821AbRLORdE>; Sat, 15 Dec 2001 12:33:04 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:50445 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282823AbRLORct>;
	Sat, 15 Dec 2001 12:32:49 -0500
Date: Sat, 15 Dec 2001 09:30:12 -0800
From: Greg KH <greg@kroah.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hangs on num-lock press
Message-ID: <20011215093012.A19136@kroah.com>
In-Reply-To: <20011215140423.0f8ac337.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011215140423.0f8ac337.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 17 Nov 2001 15:02:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 02:04:23PM +0100, Rene Rebe wrote:
> Hi all.
> 
> I have usb-only system here: MB: sis735; Keyboard: cherry 3000 USB and
> a Logitech Pilot USB mouse.
> 
> When I press num-lock the first time after boot-up or often after switching
> between X and a VC (Matrox-FB) my system hangs for a second (even sound-
> stops) and I get this message:
> 
> Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(ed)
> Dec 15 14:01:19 jackson kernel: keyboard: Timeout - AT keyboard not present?(f4)

What kernel is this?
What usb host controller driver?
SMP or UP?

thanks,

greg k-h
