Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTHUOMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTHUOMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:12:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31682 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262693AbTHUOMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:12:42 -0400
Message-ID: <3F44D34A.3040400@pobox.com>
Date: Thu, 21 Aug 2003 10:12:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update 2003-08-21
References: <Pine.LNX.4.44.0308211404320.19864-100000@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.44.0308211404320.19864-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:

> <perex@suse.cz> (03/08/20 1.1046.561.26)
>    ALSA CVS update
>    D:2003/08/20 10:59:59
>    A:Jaroslav Kysela <perex@suse.cz>
>    F:usb/usbaudio.c:1.62->1.63 
>    F:usb/usbaudio.h:1.20->1.21 
>    F:usb/usbmixer.c:1.21->1.22 
>    L:Synced USB audio driver with the latest 2.6 code
> 
> <perex@suse.cz> (03/08/20 1.1046.561.25)
>    ALSA CVS update
>    D:2003/08/16 10:54:09
>    A:Jaroslav Kysela <perex@suse.cz>
>    F:core/oss/pcm_oss.c:1.45->1.46 
>    L:Fixed open for O_RDWR when capture is not available


Allow me to express my thanks, for splitting these changes up.  This 
level of change granularity is fantastic.

Best regards,

	Jeff



