Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUIPKoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUIPKoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIPKoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:44:02 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:57541 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267554AbUIPKoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:44:00 -0400
Subject: [PATCH]: Suspend2 Merge: Device driver fixes 0/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095331529.3324.131.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 20:45:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

Here are two patches which I currently have included in Suspend2, which
fix issues with device drivers. These patches weren't written by me, but
have been submitted by users and have been in suspend and tested for at
least a few weeks. (Author in brackets).

1/2: NE2K suspend/resume support. (Arkadiusz Miskiewicz)
2/2: Suspend/resume for ali5451 driver (Bernard Blackham).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

