Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264067AbUKZUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUKZUQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUKZUPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:15:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263077AbUKZTlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:36 -0500
Date: Thu, 25 Nov 2004 14:11:36 +0100
From: Colin Leroy <colin@colino.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041125141136.1b4524ac@pirandello>
In-Reply-To: <87act6ulc5.fsf@devron.myhome.or.jp>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87pt23wdk1.fsf@devron.myhome.or.jp>
	<20041124160251.6dabbc92@pirandello>
	<87d5y3w21j.fsf@devron.myhome.or.jp>
	<20041124212811.4d8b121e@jack.colino.net>
	<87k6saunwl.fsf@devron.myhome.or.jp>
	<20041125134753.66c1fee9@pirandello>
	<87act6ulc5.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 0.9.12cvs169.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2004 at 22h11, OGAWA Hirofumi wrote:

Hi, 

> > Thank you for your help. Do I push to Andrew?
> 
> I have some patches which conflict with this patch.  So, I'll
> submit the patches after fixing it.

Ok. I suppose you'll handle the vfat one too?

-- 
Colin
