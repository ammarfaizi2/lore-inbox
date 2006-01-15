Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWAOBFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWAOBFv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWAOBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:05:51 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13802 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751603AbWAOBFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:05:50 -0500
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Andrey J. Melnikoff" <temnota@kmv.ru>
In-Reply-To: <20060114195521.GS29663@stusta.de>
References: <20060114152119.GN29663@stusta.de>
	 <1137255183.20915.0.camel@localhost.localdomain>
	 <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
	 <20060114195521.GS29663@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Jan 2006 01:07:29 +0000
Message-Id: <1137287249.26046.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-14 at 20:55 +0100, Adrian Bunk wrote:
> This patch removes the CONFIG_PDC202XX_FORCE=n case.

NAK. The Y case is the one you want to keep


