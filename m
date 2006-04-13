Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWDMSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWDMSwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWDMSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:52:41 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5013 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932435AbWDMSwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:52:40 -0400
Date: Thu, 13 Apr 2006 20:52:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
In-Reply-To: <20060413175342.GF6663@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0604132049110.20938@yvahk01.tjqt.qr>
References: <20060413052145.GA31435@MAIL.13thfloor.at>
 <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net>
 <20060413135000.GB6663@MAIL.13thfloor.at> <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
 <20060413175342.GF6663@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>[    3.583356] hda: QEMU HARDDISK, ATA DISK drive
>[    5.021521] hdc: QEMU HARDDISK, ATA DISK drive

Maybe QEMU is involved in the Oops? What if used on a normal system?



Jan Engelhardt
-- 
