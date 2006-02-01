Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWBAQJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWBAQJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWBAQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:09:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26244 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422661AbWBAQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:09:09 -0500
Date: Wed, 1 Feb 2006 17:09:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Purdie <rpurdie@rpsys.net>
cc: LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/11] LED: Add IDE disk activity LED trigger
In-Reply-To: <1138714918.6869.139.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602011707460.22529@yvahk01.tjqt.qr>
References: <1138714918.6869.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Add an LED trigger for IDE disk activity to the IDE subsystem.
>

Since I am not a real user of the led subsystem - what LED should be lit 
anyway? only the motherboard one does, and it seems to be connected 
directly to the IDE chip - I would want this as a compile-time option so I 
don't pay any extra time for any led stuff.

>Signed-off-by: Richard Purdie <rpurdie@rpsys.net>



Jan Engelhardt
-- 
