Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUHHQUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUHHQUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUHHQTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:19:30 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:31676 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265782AbUHHQSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:18:01 -0400
Date: Sun, 8 Aug 2004 16:02:16 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [0/3] via-rhine: experimental patches
Message-ID: <20040808140216.GA8181@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following batch needs testing. I don't expect any notable
regressions, but I could do with some reports on WOL (already in -mm)
and suspend/resume.

Roger
