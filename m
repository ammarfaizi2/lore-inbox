Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCRFXk>; Mon, 18 Mar 2002 00:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCRFXc>; Mon, 18 Mar 2002 00:23:32 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37102
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310501AbSCRFXU>; Mon, 18 Mar 2002 00:23:20 -0500
Date: Sun, 17 Mar 2002 21:24:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020318052440.GE2254@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/src/2.4.19-pre3-ac1-preempt/debian/tmp-image/lib/modules/2.4.19-pre3-ac1/kernel/drivers/c
har/drm/sis.o
depmod:         sis_free
depmod:         sis_malloc

I don't think this is preempt related, but I can do a test compile if you'd
like...

BTW, I'm compiling for smp.

Mike
