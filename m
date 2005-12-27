Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVL0BtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVL0BtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVL0BtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:49:09 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:31690 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932191AbVL0BtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:49:08 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: ati X300 support?
Date: Tue, 27 Dec 2005 01:49:24 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512270149.24440.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 23:59, Gerhard Mack wrote:
> hello,
>
> Does anyone know when there will be working support for the ATI X300 I
> tried the latest kernel (2.6.15-rc7) but I don't see drivers for it.

The only support the kernel should and currently does provide for this 
hardware is the "radeon" drm module. I believe the X300 is an R3xx core, so 
you might find it's supported minimally in the current Xorg release 
(6.9.0/7.0.0). My Mobility Radeon 9600 seems to work fine with this 
combination.

Alternatively you may want to look into running ATI's proprietary driver 
(fglrx). Both are compatible with 2.6.14.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
