Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVATTvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVATTvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVATTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:51:34 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:41416 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261383AbVATTvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:51:33 -0500
Subject: LVM2
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 12:51:27 -0700
Message-Id: <1106250687.3413.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently saw Alan Cox say on this list that LVM won't handle more than
2 terabytes. Is this LVM2 or LVM? What is the maximum amount of disk
space LVM2 (or any other RAID/MIRROR capable technology that is in
Linus's kernel) handle? I am talking with various people and we are
looking at Samba on Linux to do several different namespaces (obviously
one tree), most averaging about 3 terabytes, but one would have in
excess of 20 terabytes. We are looking at using 320 to 500 gigabyte
drives in these arrays. (How? IEEE-1394. Which brings a question I will
ask in a second email.)

Is RAID 5 all that bad using this software method? Is RAID 5 available?

Trever Adams
--
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety." -- Benjamin Franklin, 1759

