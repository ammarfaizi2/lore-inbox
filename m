Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVK2Vfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVK2Vfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVK2Vfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:35:50 -0500
Received: from smtpout.mac.com ([17.250.248.87]:61939 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932398AbVK2Vft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:35:49 -0500
In-Reply-To: <1133298593.16726.9.camel@gaston>
References: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com> <1133298593.16726.9.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E45E8695-5551-4297-9424-4BDC46DE28B6@mac.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH][RFC][2.6.15-rc3] snd_powermac: Add ID for Spring 2005 17" Powerbook
Date: Tue, 29 Nov 2005 16:35:42 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2005, at 16:09, Benjamin Herrenschmidt wrote:
> It's a different chip but heh, Toonie might work very basically  
> (Toonie is basically a non-configurable codec).
>
> Anyway, what is needed is a rewrite of that driver from scratch  
> with a more flexible architecture to deal with the multiple codecs  
> & busses.

I might have some time to tinker, is there any place I can get specs  
on the various chips from?  I know there's probably something in the  
Darwin sources, but I'm completely unfamiliar with those, so I'm  
interested in any advice you can offer.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



