Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVL1WiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVL1WiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVL1WiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 17:38:01 -0500
Received: from mail4.worldserver.net ([217.13.200.24]:24516 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S964936AbVL1WiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 17:38:00 -0500
X-Speedbone-Mail4Scanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-Mail4Scanner: 1.25st (Clear:RC:1(84.171.173.150):. Processed in 0.079639 secs Process 18645)
Date: Wed, 28 Dec 2005 23:37:42 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.15-rc7 ALSA sound/usb/usbaudio.c:801: cannot submit datapipe for urb
Message-ID: <20051228223742.GA23531@core.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when i try to use my usb soundcard (Terratec Aureon 5.1 USB, old
version) with 2.6.15-rc7 i get the following error message:

ALSA sound/usb/usbaudio.c:801: cannot submit datapipe for urb 5, err = -28

with 2.6.14.4 and older versions it works without problems.


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
