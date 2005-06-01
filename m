Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVFAQ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVFAQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVFAQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:28:46 -0400
Received: from mail1.kontent.de ([81.88.34.36]:46485 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261457AbVFAQ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:28:45 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Wed, 1 Jun 2005 18:28:40 +0200
User-Agent: KMail/1.8
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Gerd Knorr <kraxel@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
References: <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl>
In-Reply-To: <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011828.40551.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Juni 2005 04:23 schrieb Horst von Brand:
> Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> 
> [...]
> 
> > Well I remember the first time I saw devfs running, I thought "Wow
> > finally I have a way to find the disc that is scsi id 3 on controller 0
> > even if I add a device at id 2 after setting up the system", something
> > most unix systems have always had, but linux made hard (you had to
> > somehow figure out which id mapped to which /dev/sd* entry, which from a
> > users perspective wasn't trivial, and of course keeping your fstab in
> > sync with the mapping was a pain).
> 
> Why? Just use LABELs, ou UUIDs.

For burning a CD? A label is hardly practical and UUIDs are rare. Sometimes
addressing the medium won't do and you need the device.

	Regards
		Oliver
