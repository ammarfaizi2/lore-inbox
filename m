Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSFAUWb>; Sat, 1 Jun 2002 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317057AbSFAUWa>; Sat, 1 Jun 2002 16:22:30 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:41908 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S317056AbSFAUW3>;
	Sat, 1 Jun 2002 16:22:29 -0400
Date: Sat, 1 Jun 2002 16:22:30 -0400
From: Jeff Garzik <garzik@gtf.org>
To: Nikolaus Filus <NFilus@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: de4x5 driver: driver freezes system
Message-ID: <20020601162230.B4535@gtf.org>
In-Reply-To: <20020531233651.B595@nfilus.dyndns.org> <3CF7F60F.40802@mandrakesoft.com> <20020601103403.A750@nfilus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 10:34:03AM +0200, Nikolaus Filus wrote:
> On Fri, May 31, 2002 at 06:15:43PM -0400, Jeff Garzik wrote:
> >Does the tulip driver not work for you?
> 
> It's not a problem of working or not working, but this driver freezes a
> system when compiled into the kernel and no such card is present. That
> shouldn't happen. There isn't even any hint during booting, that would point
> to the driver, when something goes wrong.

"de4x5" != "tulip"

Does the tulip driver work for you?  You were talking about de4x5.

	Jeff


