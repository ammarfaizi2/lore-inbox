Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFAQBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFAQBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVFAP6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:58:22 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31438 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261444AbVFAP43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:56:29 -0400
Date: Wed, 1 Jun 2005 11:56:29 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Gerd Knorr <kraxel@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601155629.GK23488@csclub.uwaterloo.ca>
References: <20050531190556.GK23621@csclub.uwaterloo.ca> <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 10:23:42PM -0400, Horst von Brand wrote:
> Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> > Well I remember the first time I saw devfs running, I thought "Wow
> > finally I have a way to find the disc that is scsi id 3 on controller 0
> > even if I add a device at id 2 after setting up the system", something
> > most unix systems have always had, but linux made hard (you had to
> > somehow figure out which id mapped to which /dev/sd* entry, which from a
> > users perspective wasn't trivial, and of course keeping your fstab in
> > sync with the mapping was a pain).
> 
> Why? Just use LABELs, ou UUIDs.

Great if those worked on ALL filesystems, which to my knowledge they do
not.  Last time I tried to use labels to mount filesystems, I gave up on
it when I discovered swap didn't support it.  I haven't bothered with
them since.

Len Sorensen
