Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRJFXqo>; Sat, 6 Oct 2001 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJFXqe>; Sat, 6 Oct 2001 19:46:34 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:31751 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275839AbRJFXqV>;
	Sat, 6 Oct 2001 19:46:21 -0400
Date: Sat, 6 Oct 2001 16:40:03 -0700
From: Greg KH <greg@kroah.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 + ibmcam : hard freeze on read()
Message-ID: <20011006164003.A11417@kroah.com>
In-Reply-To: <1002396347.2125.5.camel@gromit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002396347.2125.5.camel@gromit>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 03:25:46PM -0400, Michael Rothwell wrote:
> 
> Has anyone else seen any USB, v4l, or ibmcam problems in 2.4.10?

Known problem with usb-uhci.  Please use 2.4.11-pre4 or uhci.o.

thanks,

greg k-h
