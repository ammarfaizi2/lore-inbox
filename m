Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285537AbRLNVsI>; Fri, 14 Dec 2001 16:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285534AbRLNVr6>; Fri, 14 Dec 2001 16:47:58 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:1291
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S285532AbRLNVrp>; Fri, 14 Dec 2001 16:47:45 -0500
Date: Fri, 14 Dec 2001 16:59:22 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: Jeff <piercejhsd009@earthlink.net>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
Message-ID: <20011214165921.A25469@animx.eu.org>
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net> <20011214064202.A24719@animx.eu.org> <3C1A0DF6.5030401@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C1A0DF6.5030401@korseby.net>; from Kristian Peters on Fri, Dec 14, 2001 at 03:34:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I get this same thing with a scsi cdrom at work.  I have 2 of the exact same
> > drives.  a Teac cd-535s v1.0a  the first one I get that message, the second
> > works.  However, the first one won't pull the tray back in via software.
> 
> 
> Is the first drive connected to /dev/hdb ? Does eject work on /dev/scd0 or 
> /dev/hdb ?

Those drives are scsi drives, not IDE.  they are the exact same drive but on
different scsi controllers.  I *HAVE* swapped them, it's the drive.

The scsi controllers are both adaptec aha-2940u cards.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
