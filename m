Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270554AbTGSW1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270555AbTGSW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 18:27:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:28628 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270554AbTGSW13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 18:27:29 -0400
Date: Sat, 19 Jul 2003 15:42:20 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Ga=EBl?= Le Mignot <kilobug@freesurf.fr>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030719224220.GA1950@kroah.com>
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk> <1058626962.30424.6.camel@stargate> <plopm3lluu8mv0.fsf@drizzt.kilobug.org> <20030719172311.GA23246@work.bitmover.com> <plopm3he5i8l4h.fsf@drizzt.kilobug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <plopm3he5i8l4h.fsf@drizzt.kilobug.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 07:46:54PM +0200, Gaël Le Mignot wrote:
>  > Drivers and networking account for about 50% of the total lines of code.
>  > The bulk of the work in any operating system is typically drivers.  The
>  > generic part of Linux (non-driver, non-file system) is tiny compared to 
>  > the rest.
> 
> Maybe  for  you,  an  OS  is  drivers.  For  me,  it's  a  design,  an
> architecture, a  philosophy, and a way  to defend a value  that is not
> important for you: Freedom.

Heh, let's see how well your OS works in the real world without those
drivers :)

greg k-h
