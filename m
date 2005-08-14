Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVHNKKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVHNKKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVHNKKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:10:20 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:23524 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S932472AbVHNKKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:10:20 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: 2.6.13-rcX really this bad ?
Date: Sun, 14 Aug 2005 10:10:18 +0000 (UTC)
Organization: Cistron
Message-ID: <ddn5aa$glm$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1124014218 17078 62.216.30.70 (14 Aug 2005 10:10:18 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted a couple of times than my newsserver is not stable
with any 2.6.13-rcX kernels.
Last kernel that survived is 2.6.12-mm1 (18+days)
Of course i can just stick with that kernel, but i thought it would
be wise to live on the edge and run a reasonable loaded server with
the latest/greatest. This ends in disaster though...

These are last uptimes, all reset by panic on reset.

reboot   system boot  2.6.13-rc6-git5  Sun Aug 14 02:56    (09:07)
reboot   system boot  2.6.13-rc6-git4  Fri Aug 12 16:50    (1+19:13)
reboot   system boot  2.6.13-rc6-git3  Fri Aug 12 12:32    (04:16)
reboot   system boot  2.6.13-rc6-git3  Thu Aug 11 13:18    (1+03:29)
reboot   system boot  2.6.13-rc6-git2  Thu Aug 11 12:40    (00:35)
reboot   system boot  2.6.13-rc6-git1  Wed Aug 10 13:24    (23:52)
reboot   system boot  2.6.13-rc6       Wed Aug 10 02:46    (10:35)
reboot   system boot  2.6.13-rc6       Mon Aug  8 16:52    (1+20:29)
reboot   system boot  2.6.13-rc6       Sun Aug  7 22:07    (2+15:14)

Since i got no feedback on my previous posts, i either bring it 
the wrong way, or people don't care and i ought to shut up.
I think however that just before releasing a new stable kernel these
kind of feedback could be healthy to ironout some bugs.

For now i'll switch back to 2.6.12-mm1 and follow this mailling list
and try again when i the problems seem to have been solved.

Danny

