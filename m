Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUJaSel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUJaSel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUJaSel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:34:41 -0500
Received: from 81-223-104-78.krugerstrasse.xdsl-line.inode.at ([81.223.104.78]:41363
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S261497AbUJaSee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:34:34 -0500
Date: Sun, 31 Oct 2004 19:35:02 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: linux-kernel@vger.kernel.org
Subject: Raid1 DM vs MD
Message-ID: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After loosing some Data this week ... the question upon with technology to 
use for Soft-RAID1 emerged the last days.

So which one is the recomended approach?

Should I use MD or DM?

One benefit on using MD is that one can use it for root-devices without 
initrd.

But where will the development go?

Will MD be supported in the future or will it be replaced by DM?

Will there be other raid levels supported in DM?

Which one has better Clean/Dirty recognition/detection?

I had one MD-Raid1 where a good copy of the mirror was overwritten by the 
bad (old) copy ... I lost 3 Month worth of data and I am expecting loosing 
a linux project and in the worst case - even a court case :(

Questions upon questions.

Sooner or later I'l migrate from SW-Raid to a HW-Raid-Controller ...

Thanx
Kianusch

---
   SK-TECH.net
   http://www.sk-tech.net
