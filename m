Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbREaTzk>; Thu, 31 May 2001 15:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbREaTza>; Thu, 31 May 2001 15:55:30 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:33799 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263195AbREaTzY>;
	Thu, 31 May 2001 15:55:24 -0400
Date: Thu, 31 May 2001 11:56:44 -0700
From: Greg KH <greg@kroah.com>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
Message-ID: <20010531115644.B12797@kroah.com>
In-Reply-To: <20010531203908.A23936@middle.of.nowhere> <20010531110642.A12797@kroah.com> <20010531214835.A3590@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010531214835.A3590@middle.of.nowhere>; from thunder7@xs4all.nl on Thu, May 31, 2001 at 09:48:35PM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:48:35PM +0200, thunder7@xs4all.nl wrote:
> On Thu, May 31, 2001 at 11:06:42AM -0700, Greg KH wrote:
> > On Thu, May 31, 2001 at 08:39:08PM +0200, thunder7@xs4all.nl wrote:
> > > What information would be necessary to debug this?
> > 
> > Which kernel version?
> > 
> > greg k-h
> > 
> 2.4.5-ac4, but I rebooted in 2.4.4 and it did the same.

Is the BIOS set to "Plug and Play supported OS" somewhere?  If not, try
enabling it.

Also the MPS 1.4 boot messages would be helpful :)

thanks,

greg k-h
