Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTK1JOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTK1JOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:14:50 -0500
Received: from smtp5.wanadoo.nl ([194.134.35.176]:36402 "EHLO smtp5.wanadoo.nl")
	by vger.kernel.org with ESMTP id S262081AbTK1JOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:14:48 -0500
From: Vladimir Lazarenko <vlad@lazarenko.net>
Organization: Favoretti Spagettolino Inc
To: kees.bakker@altium.nl (Kees Bakker)
Subject: Re: 2.6.0-test9/10 speedtouch glitch
Date: Fri, 28 Nov 2003 10:14:31 +0100
User-Agent: KMail/1.5.93
References: <200311272023.56413.vlad@lazarenko.net> <200311280001.30220.baldrick@free.fr> <siwu9kuak1.fsf@koli.tasking.nl>
In-Reply-To: <siwu9kuak1.fsf@koli.tasking.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200311281014.31339.vlad@lazarenko.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 November 2003 10:06, Kees Bakker wrote:
> >>>>> Duncan Sands writes:
> >
> > On Thursday 27 November 2003 23:39, Vladimir Lazarenko wrote:
> >> Using Debian/sid with latest available usbmgr.
> >> Tho the module itself loads successfully, just that modem_run isn't able
> >> to see the device, I think at that point hotplug has to complete
> >> already?
> >
> > What error message do you get exactly?  When running what command?
> I always thought that modem_run (the user-space driver) and the kernel
> driver don't match. Am I wrong?

Yes, modem_run is a tool which loads up the firmware into the modem, and can 
perfectly match with kernel driver, by passing it the key -k upon startup. 
(Try updating to the latest sppedbuncle package?)

Anyway, Duncan, messages will be delivered later today. :-)


> 		Kees

-- 
Best regards,
Vladimir Lazarenko
