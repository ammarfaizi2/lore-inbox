Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTHYXDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTHYXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:03:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:16600 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262440AbTHYXBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 19:01:35 -0400
From: Christian Hesse <news@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 hangs with pcmcia and linux-wlan
Date: Tue, 26 Aug 2003 01:00:37 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308260059.00737.news@earthworm.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running kernels with pcmcia-cs-3.2.4 and linux-wlan-ng-0.2.1-pre11 (also 
tried 0.2). With 2.4.22-rc3 to final the system hangs if I insert my LevelOne 
WPC-0100 (Prism-II-base wlan), no output at all. Everything worked well up to 
and including 2.4.22-rc2.

Regards,
  Christian

