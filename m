Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTKBLzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 06:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTKBLzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 06:55:08 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:22441 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261660AbTKBLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 06:55:03 -0500
Date: Sun, 2 Nov 2003 12:51:02 +0100 (CET)
From: Ingo Buescher <usenet-2003@r-arcology.de>
X-X-Sender: gallatin@nathan.cybernetics.com
To: linux-kernel@vger.kernel.org
Subject: Re: Via 8235 arts problem (2.6-test9)
In-Reply-To: <20031102033556.83160.qmail@web25203.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311021246490.6934@anguna.ploreargvpf.pbz>
References: <20031102033556.83160.qmail@web25203.mail.ukl.yahoo.com>
X-Binford: 6100 (more power)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Chris D wrote:

> Date: Sun, 2 Nov 2003 03:35:56 +0000 (GMT)
> From: Chris D <mnni2001@yahoo.co.uk>
> To: linux-kernel@vger.kernel.org
> Subject: Via 8235 arts problem (2.6-test9)
>
> Just finished installed the latest kernel.  Anyway,
> alsa seems to work fine with my onboard soundcard (Via
> 8235 on an Epox Motherboard). Arts on the other hand
> isn't working properly at all.   Rather than sound, I
> get a load of static noise.  Xmms, Mlayer etc.  work
> fine with the alsa plugin, but crash if using the arts plugin.

Same here (MB: Epox 8K5A2). I had similar problems under linux-2.4 with
alsa < 0.9.6. Upgrading to 0.9.6 fixed it. Don't know what to do with
linux-2.6.

IB
-- 
===========================================================================
Ingo Buescher <usenet-2003@r-arcology.de>
"What the ancients called a clever fighter is one who not only wins,
but excels in winning with ease." -- Sun Tzu
