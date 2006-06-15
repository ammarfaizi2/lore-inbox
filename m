Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031091AbWFOSud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031091AbWFOSud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031093AbWFOSud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:50:33 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:24206 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1031091AbWFOSud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:50:33 -0400
Message-ID: <4491ABF7.4090204@drzeus.cx>
Date: Thu, 15 Jun 2006 20:50:31 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
References: <1150385605.3490.85.camel@localhost.localdomain>	 <449191EE.2090309@drzeus.cx> <1150393058.3490.120.camel@localhost.localdomain>
In-Reply-To: <1150393058.3490.120.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I'd have thought that one was a "Duh whoops, fix it now" kind of
> submission for 2.6.17
>
>   

Yes and no. It's for a code path that's never supposed to be hit (and
isn't except for hardware so broken it doesn't work anyway). So I
figured I might as well send it in with the rest of the patches.

I'm fine either way though. I'll just pop that patch from my set.

Rgds
Pierre

