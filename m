Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbULMIFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbULMIFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 03:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbULMIFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 03:05:35 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:34784 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261981AbULMIF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 03:05:29 -0500
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
Date: Mon, 13 Dec 2004 12:05:27 +0400
User-Agent: KMail/1.6.2
References: <1102888882.15558.2.camel@ksyrium.local> <1102889485.15558.5.camel@ksyrium.local> <Pine.LNX.4.61.0412122314560.10353@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412122314560.10353@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412131205.27786.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon December 13 2004 2:15 am, Jan Engelhardt wrote:
> >> >The code apparently can display the horizon, but cannot prevent
> >> >shocks :(
> >>
> >> How can something prevent a shock if it does not know before? What I
> >> mean is that if I smack a harddrive, it can hardly evade it... nor can
> >> it prevent me from smacking it.
> >
> >It can only prevent shocks when it detects tilts... like when the laptop
> >shakes in a moving vehicle for example..
>
> Ah that's reasonable, like I'm dropping it (will probably tilt due to
> physics) and then hit the ground.
> But what will it do to prevent against the schock, now that it knows it is
> tilted?
When a tilt is detected, it would park the heads ? so that it would not 
affected from the larger shock ?

The platter/head is affected in a case where the arm swings away, even from 
the powerful magnet to crash against the platter. If the arm is locked, such 
that it does not move when a tilt is detected, (The tilt before the shock) 
the arm is parked and locked (more locking than the simple magnet) ?
 
Manu
>
>
>
> Jan Engelhardt
