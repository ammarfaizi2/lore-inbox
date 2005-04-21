Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVDULis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVDULis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDULis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:38:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45508 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261293AbVDULir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:38:47 -0400
Date: Thu, 21 Apr 2005 13:38:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: tvrtko.ursulin@sophos.com
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050421113829.GB7148@elf.ucw.cz>
References: <OFD632A3BF.A81F7157-ON80256FEA.003F0182-80256FEA.003F2EB2@sophos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD632A3BF.A81F7157-ON80256FEA.003F0182-80256FEA.003F2EB2@sophos.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Without this patch, Linux provokes emergency disk shutdowns and
> >similar nastiness. It was in SuSE kernels for some time, IIRC.
> 
> OMG! And I did try to raise that issue 10 months ago, see below:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0242.html

Heh, verify that this patch works for you and it might finally get
fixed...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
