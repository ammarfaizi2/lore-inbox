Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUHCTcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUHCTcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHCTcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:32:02 -0400
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:45514
	"EHLO redscar") by vger.kernel.org with ESMTP id S266807AbUHCTb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:31:59 -0400
Subject: Re: [2.6 patch] let AIC7{9,X}XX_BUILD_FIRMWARE depend
	on!PREVENT_FIRMWARE_BUILD
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Nathan Bryant <nbryant@optonline.net>, Sam Ravnborg <sam@ravnborg.org>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, Adrian Bunk <bunk@fs.tum.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <410FD035.6080905@adaptec.com>
References: <20040801185543.GB2746@fs.tum.de>
	<20040801191118.GA7402@mars.ravnborg.org> <410FA577.4040602@adaptec.com>
	<410FBDAA.4070907@optonline.net>
	<1091550985.2816.10.camel@laptop.fenrus.com>  <410FD035.6080905@adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 Aug 2004 12:31:55 -0700
Message-Id: <1091561517.1942.0.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 10:49, Luben Tuikov wrote:
> Yes, no problem.  Whatever you guys want.
> I can provide small incremental patches (right out of
> perforce), and generate incremantal BKs (will have to look into
> that).

Actually, small incremental patches across the scsi list is what I'd
prefer.  I can take care of doing the BK stuff to pull the patches
straight off the list.

James


