Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031135AbWFOTFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031135AbWFOTFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031140AbWFOTFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:05:30 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:25998 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1031135AbWFOTF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:05:29 -0400
Message-ID: <4491AF77.6010902@drzeus.cx>
Date: Thu, 15 Jun 2006 21:05:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: sdhci-devel@list.drzeus.cx, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
References: <1150385605.3490.85.camel@localhost.localdomain>	<449191EE.2090309@drzeus.cx> <4491AE02.4070008@gentoo.org>
In-Reply-To: <4491AE02.4070008@gentoo.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Is your queue publicised anywhere? I have a new laptop, which has a card 
> reader supposedly supported by sdhci, but it doesn't work. I would like 
> to confirm that I am running the latest code before I start diagnosing it...
>
>   

Not in a git format as I use StGIT and it tends to be incompatible with
pulls. My patches usually circulate a bit on the sdhci-devel list before
I pass them on to Russell. This time the set is rather large though:

http://list.drzeus.cx/pipermail/sdhci-devel/2006-May/000809.html

Rgds
Pierre

