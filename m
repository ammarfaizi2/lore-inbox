Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWAUREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWAUREq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWAUREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 12:04:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52387 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932214AbWAUREq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 12:04:46 -0500
Date: Sat, 21 Jan 2006 18:04:44 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD assigned wrong SCSI level when using SCSI emulation
In-Reply-To: <20060121154012.66687.qmail@web50210.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0601211803490.2567@yvahk01.tjqt.qr>
References: <20060121154012.66687.qmail@web50210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>I've noticed that since I upgraded to 2.6.15, my IDE DVD ROM
>>>is assigned a bogus SCSI level. Here is output from /proc/scsi/scsi:
>>
>>You are not using ide-scsi, are you?
>
>Yes, I am. as a module. I stated that in the original post.
>
I remember people called it broken.


Jan Engelhardt
-- 
