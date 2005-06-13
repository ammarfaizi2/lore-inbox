Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFMWar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFMWar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVFMW2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:28:40 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:3749 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261515AbVFMW0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:26:44 -0400
Date: Tue, 14 Jun 2005 00:26:40 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Subject: 2.6.12-rc6 aic7yyy is _very_ slow during boot
Message-ID: <20050613222640.GA7972@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if my previous posting has been filtered out so here's a
second attempt.

While booting 2.6.12-rc6 the indicated SCSI driver seems
to hang for about 30 seconds. A /var/log/messages excerpt:
 http://www.frankvm.com/tmp/aic7yyy.log (long)

I saw some patches for investigating post-rc2 breakage but they don't
apply on plain 2.6.12-rc6. And it may be a different problem.

-- 
Frank
