Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWAQRLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAQRLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAQRLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:11:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45445 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932197AbWAQRLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:11:04 -0500
Date: Tue, 17 Jan 2006 18:10:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <Pine.LNX.4.64.0601170450020.2377@p34>
Message-ID: <Pine.LNX.4.61.0601171810320.18569@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601161957300.16829@p34> <20060117012319.GA22161@linuxace.com>
 <Pine.LNX.4.64.0601170450020.2377@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> NFS is still twice as slow as FTP, but best with a r/w size of 8192.

Screams for a kftpd ;)


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
