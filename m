Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSIEAmj>; Wed, 4 Sep 2002 20:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSIEAmi>; Wed, 4 Sep 2002 20:42:38 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:40207 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316289AbSIEAmi>;
	Wed, 4 Sep 2002 20:42:38 -0400
Date: Wed, 4 Sep 2002 17:45:14 -0700
From: Greg KH <greg@kroah.com>
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in pl2303 driver
Message-ID: <20020905004514.GB8947@kroah.com>
References: <3D7117D3.5080100@nothing-on.tv> <20020901005124.GA15259@kroah.com> <3D7291BB.1010004@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D7291BB.1010004@nothing-on.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 11:16:27PM +0100, Tony Hoyle wrote:
> A clue perhaps?  I switch from the uhci to the usb-uhci driver and the 
> oops stopped happening (there were a couple of make mrproper/rebuilds in 
> between too).

That makes me very suspicious.  If you can reproduce it with the uhci
driver again, please let me know.  I'm getting some odd reports of a
problem like this, but I'm unable to reproduce it, and others are having
a hard time too.

thanks,

greg k-h
