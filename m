Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbTHUPpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTHUPpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:45:06 -0400
Received: from gate.perex.cz ([194.212.165.105]:12563 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262786AbTHUPpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:45:01 -0400
Date: Thu, 21 Aug 2003 17:43:43 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update 2003-08-21
In-Reply-To: <3F44D34A.3040400@pobox.com>
Message-ID: <Pine.LNX.4.44.0308211736140.19864-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Jeff Garzik wrote:

> Jaroslav Kysela wrote:
> 
> > <perex@suse.cz> (03/08/20 1.1046.561.26)
> >    ALSA CVS update
> >    D:2003/08/20 10:59:59
> >    A:Jaroslav Kysela <perex@suse.cz>
> >    F:usb/usbaudio.c:1.62->1.63 
> >    F:usb/usbaudio.h:1.20->1.21 
> >    F:usb/usbmixer.c:1.21->1.22 
> >    L:Synced USB audio driver with the latest 2.6 code
> > 
> > <perex@suse.cz> (03/08/20 1.1046.561.25)
> >    ALSA CVS update
> >    D:2003/08/16 10:54:09
> >    A:Jaroslav Kysela <perex@suse.cz>
> >    F:core/oss/pcm_oss.c:1.45->1.46 
> >    L:Fixed open for O_RDWR when capture is not available
> 
> 
> Allow me to express my thanks, for splitting these changes up.  This 
> level of change granularity is fantastic.

All thanks are going to the cvsps utility which generates CVS changesets.
I spent only a few hours with the python scripting to create a ALSA CVS ->
Linux BK tree converter. I have to do some merging still manually, but
it is a life of two independent repository trees.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


