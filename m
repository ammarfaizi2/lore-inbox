Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbTCYHQk>; Tue, 25 Mar 2003 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbTCYHQk>; Tue, 25 Mar 2003 02:16:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8977 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261605AbTCYHQj>;
	Tue, 25 Mar 2003 02:16:39 -0500
Date: Mon, 24 Mar 2003 23:27:14 -0800
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325072714.GE12590@kroah.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de> <20030325003048.GC10505@kroah.com> <20030325041802.GA535@zip.com.au> <20030325043454.GJ11874@kroah.com> <20030325055613.GB464@zip.com.au> <20030325065125.GA12590@kroah.com> <20030325072230.GA496@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325072230.GA496@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 06:22:30PM +1100, CaT wrote:
> On Mon, Mar 24, 2003 at 10:51:25PM -0800, Greg KH wrote:
> > On Tue, Mar 25, 2003 at 04:56:13PM +1100, CaT wrote:
> > > > You will need the last one, I've attached it here.  Let me know if it
> > > > fixes this or not.
> > > 
> > > I grabbed the entire patchset you posted for 2.5.66 and applied. Booted
> > > without oops. Me happy. :)
> > 
> > Nice, thanks for testing, I really appreciate it.
> 
> No worries. Glad to help. :)
> 
> One point of note though. Should this be happening?

I know I see this on the 2.5, and the original 2.4 i2c code, I think
it's just part of the probing process.  The people on the sensor's list
can tell you more, but if the adm1021 driver seems to work, I wouldn't
worry about it :)

thanks,

greg k-h
