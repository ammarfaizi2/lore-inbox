Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWBMR1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWBMR1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBMR1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:27:25 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:11746 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932363AbWBMR1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:27:24 -0500
From: Luke-Jr <luke@dashjr.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:27:25 +0000
User-Agent: KMail/1.9
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       chris@gnome-de.org, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <43F088AB.nailKUSB18RM0@burner> <Pine.LNX.4.61.0602131742460.24297@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602131742460.24297@yvahk01.tjqt.qr>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131727.26945.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 16:43, Jan Engelhardt wrote:
> >> Well, "any user" just opens his Windows Explorer and takes a look at the
> >> icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> >> interesting to see professional programmers often argue that a
> >
> >This is not true: a drive letter mapping does not need to exist on MS-WIN
> >in order to be able to access it via ASPI or SPTI.
>
> I have to support this view. Linux filesystems do not show up in Windows
> Explorer (because there's obviously an fs driver lacking), but there's
> always a way to damage your Linux from within Windows.

Really? My Windows-using friend has all his Linux partitions fully visible and 
usable in Windows Explorer...
