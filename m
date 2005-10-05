Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVJEPR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVJEPR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVJEPR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:17:58 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:26523 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S965210AbVJEPR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:17:58 -0400
Date: Wed, 5 Oct 2005 19:17:37 +0400 (MSD)
From: Evgeny Rodichev <er@sai.msu.su>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] libata: Marvell SATA support (DMA mode)
 (resend: v0.22)
In-Reply-To: <4341E420.6070808@pobox.com>
Message-ID: <Pine.GSO.4.63.0510051912230.10241@ra.sai.msu.su>
References: <20050930053600.F3B821CDD0@lns1058.lss.emc.com> <4341E420.6070808@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Jeff Garzik wrote:

> applied
>

This patch leads to freeze with Marvell MV88SX6041 4-port SATA II PCI-X 
Controller (rev 03), as I wrote already
(http://www.uwsg.iu.edu/hypermail/linux/kernel/0510.0/0203.html)

It is impossible to reboot the system without  harware reset (after modprobe).

_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
