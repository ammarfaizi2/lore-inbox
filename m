Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUE3U46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUE3U46 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUE3Uzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:55:42 -0400
Received: from main.gmane.org ([80.91.224.249]:34768 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264384AbUE3UzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:55:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Why is proper NTFS-driver difficult?
Date: Sun, 30 May 2004 22:54:52 +0200
Message-ID: <MPG.1b246889bd6dd2049896af@news.gmane.org>
References: <40BA1FD5.9080902@minimum.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-113-140.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Olsson wrote:
> Hello,
> 
> 
> I was wondering why is there no Linux NTFS-driver which allows full 
> writing etc? Is there something that makes this particular difficult to 
> implement? I mean Linux supports so many file systems, why has proper 
> NTFS support been neglected?
> 
> Is there any file system I can use which satisfies these criteria:
> A) works in both Linux and Windows
> B) handle >4GB files
> C) handle 120GB partitions

ext2/3

There are (open source) ext2/3 drivers for Windows.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

