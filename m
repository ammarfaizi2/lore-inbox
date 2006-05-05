Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWEEMyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEEMyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWEEMyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:54:31 -0400
Received: from smtp-4.hut.fi ([130.233.228.94]:42883 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id S1750795AbWEEMya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:54:30 -0400
Date: Fri, 5 May 2006 15:54:12 +0300 (EEST)
From: Jan Wagner <jwagner@kurp.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: support for sata7 Streaming Feature Set?
Message-ID: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TKK-Virus-Scanned: by amavisd-new-2.1.2-hutcc at katosiko.hut.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

anyone know if the now already somewhat old Streaming Feature Set of
ATA/ATAPI 7 is going to be implemented in the kernel ata functions?

According to one web site that contains hdreg.h
http://www.koders.com/c/fidCD7293464D782E48F93EEF8A71192F1BF28FC205.aspx
there's at least some kind of mention in that include file about streaming
feature set, kernel 2.6.10. However in 2.6.16 it seems to be gone again.
Any ideas if this will be implemented, or how to use it with e.g. hdparm
right now?

many thanks!
 - Jan
