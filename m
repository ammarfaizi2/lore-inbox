Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285334AbRLNLak>; Fri, 14 Dec 2001 06:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285336AbRLNLab>; Fri, 14 Dec 2001 06:30:31 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:45834
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S285334AbRLNLaW>; Fri, 14 Dec 2001 06:30:22 -0500
Date: Fri, 14 Dec 2001 06:42:02 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: Jeff <piercejhsd009@earthlink.net>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
Message-ID: <20011214064202.A24719@animx.eu.org>
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C19DEAF.4080703@korseby.net>; from Kristian Peters on Fri, Dec 14, 2001 at 12:12:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > cdrecord: Warning: controller returns wrong size for CD capabilities
> > page.
> >         0,0,0     0) 'E-IDE   ' 'CD-ROM 50X      ' '50  ' Removable
> > CD-ROM

I get this same thing with a scsi cdrom at work.  I have 2 of the exact same
drives.  a Teac cd-535s v1.0a  the first one I get that message, the second
works.  However, the first one won't pull the tray back in via software.

> Correct me if I'm wrong, but that looks like cdrecord doesn't recognize your 
> cd-rom correctly. Do you have added that drive also to your lilo.conf ?
> 
> Normally it would be enough to load the modules without any specific parameters.
> 
> Could you post your dmesg-output + lilo.conf parameters if possible ?
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
