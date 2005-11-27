Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVK0IYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVK0IYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 03:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVK0IYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 03:24:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31125 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750911AbVK0IYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 03:24:01 -0500
Date: Sun, 27 Nov 2005 09:23:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Brown <dmlb2000@gmail.com>
cc: mhf@users.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
In-Reply-To: <9c21eeae0511261511o4083b0f2we5080b550f592253@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511270921430.14029@yvahk01.tjqt.qr>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> 
 <20051126223921.E7EF31AC3@hornet.berlios.de> 
 <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com> 
 <20051126225656.04D3D1AC3@hornet.berlios.de>
 <9c21eeae0511261511o4083b0f2we5080b550f592253@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Aha, that option isn't in man page for tar but it is in the info page
>for it... odd

GNU does not officially create/use manpages.
I think it's the well known linux-manpages project that maintains them.

>Thanks, but I'd still like to know why the tarball isn't goinb to be
>fixed on the main site.

A hint, if --no-same-permission is too much to type, you may abbreviate it 
with --no-same-p


Jan Engelhardt
-- 
