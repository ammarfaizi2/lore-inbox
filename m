Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268433AbUHLHN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268433AbUHLHN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUHLHN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:13:58 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:50777 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S268433AbUHLHNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:13:55 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Linux running with / completely broken in 2.2, 2.4, 2.6
From: <fabian.frederick@prov-liege.be>
Cc: <fabian.frederick@prov-liege.be>
Date: Thu, 12 Aug 2004 09:02:05 +0200
Reply-To: <fabian.frederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.8.0.56]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S268433AbUHLHNz/20040812071355Z+889@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I've been facing 3 times the same problem with 2.2.X, 2.4.X et 2.6.X kernel having ext2 root partition and lately reiserfs (with different HD every time, 2 completely different hardware and 3 different SuSE)... System runs netatalk, samba and is a backup unit (huge ncftpput from outside).
  Symptom is always the same : The box keeps running, but I'm unable to access / directory ... If I try to reboot, box is completely broken -> no grub.If I try to rebuild-tree or anything, I'm told I've got bad blocks.The only way to use HD again is to reformat in ext2 and use it as it seems the root tree is deleted ...

Any idea ? That box is still running.Can I do something before reinstalling ...again ?

PS : Could you cc me ?

Best regards,
FabF

___________________________________



