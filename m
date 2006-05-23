Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWEWCQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWEWCQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWEWCQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:16:16 -0400
Received: from leitseite.net ([213.239.214.51]:61385 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1751255AbWEWCQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:16:15 -0400
Date: Tue, 23 May 2006 04:16:25 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <200605222200.18351.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0605230407320.25860@pc>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
just wanted to remark that I never liked that bzip was replaced by bzip2 
(were there license issues?) since bzip's compression was/is often 
stronger:

39843104 Mar 28 09:33 linux-2.6.15.7.tar.bz2
39423739 Mar 28 09:33 linux-2.6.15.7.tar.bz

Not a big difference in this case but still a step back. I for once am 
keeping my bzip binary.. does anyone know where the source can still be 
found?

Regards, Nuri
