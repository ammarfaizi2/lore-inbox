Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbULRUHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbULRUHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULRUHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:07:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23465 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261221AbULRUHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:07:32 -0500
Date: Sat, 18 Dec 2004 21:07:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Leber <christian@leber.de>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [bugreport] Problem when trying to mount CD/DVD (2.6.10-rc{1 to
 3-bk12}); most likely it's ide-scsi
In-Reply-To: <20041218184021.GA6795@core.home>
Message-ID: <Pine.LNX.4.61.0412182106350.21592@yvahk01.tjqt.qr>
References: <20041218184021.GA6795@core.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    3-bk12}); most likely it's ide-scsi

Yes, it's very likely ide-scsi. I've heard reports of that it is totally 
unmaintained and thus broken now that CD writing can be done over pure IDE.



Jan Engelhardt
-- 
ENOSPC
