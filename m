Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290748AbSA3XtL>; Wed, 30 Jan 2002 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSA3XtB>; Wed, 30 Jan 2002 18:49:01 -0500
Received: from codepoet.org ([166.70.14.212]:46525 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290729AbSA3Xsq>;
	Wed, 30 Jan 2002 18:48:46 -0500
Date: Wed, 30 Jan 2002 16:48:48 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130234847.GA25577@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020130211422.GA22705@codepoet.org> <E16W3no-0000Jv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16W3no-0000Jv-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 30, 2002 at 11:06:04PM +0000, Alan Cox wrote:
> > bravery.  That pile of dung does not need a "small-stuff"
> > maintainer.  It needs to be forcefully ejected and replaced with
> > extreme prejudice.  It is amazing that ancient stuff works as
> > well as it does...
> 
> A lot of the apparently really ugly drivers turned out to be very good code
> hiding under 10 years of history and core code changes and
> assumptions. See the NCR5380 stuff I've now all done (in 2.4.18pre) - dont 
> use 2.5.* NCR5380 it'll probably corrupt your system if it doesn't just die
> or hang - Linus apparently merged untested stuff to the old broken driver.

This is in the latest -ac kernels?  Cool, I'll go take a close
look.  I'm very anxious to see a SCSI layer that doesn't suck
get put in place,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
