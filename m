Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWEDRmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWEDRmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWEDRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:42:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26578 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030232AbWEDRmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:42:03 -0400
Date: Thu, 4 May 2006 19:41:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roy Rietveld <rwm_rietveld@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
In-Reply-To: <BAY105-F1952B97471150282623600E9B40@phx.gbl>
Message-ID: <Pine.LNX.4.61.0605041940540.29706@yvahk01.tjqt.qr>
References: <BAY105-F1952B97471150282623600E9B40@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to send ethernet packets with 1400 bytes payload.
> I wrote a small program witch sends a buffer of 1400 bytes in a endless loop.
> The problem is that a would like 100Mbits throughtput but when i check this
> with ethereal.
> I only get 40 MBits. I tried sending with an UDP socket and RAW socket. I also
> tried sendfile.
> The RAW socket gives the best result till now 50 MBits throughtput.

Limitation of Ethernet.



Jan Engelhardt
-- 
