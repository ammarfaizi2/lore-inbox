Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbRFSC6k>; Mon, 18 Jun 2001 22:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbRFSC6a>; Mon, 18 Jun 2001 22:58:30 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:772 "HELO sh0n.net")
	by vger.kernel.org with SMTP id <S263442AbRFSC6O>;
	Mon, 18 Jun 2001 22:58:14 -0400
Date: Mon, 18 Jun 2001 22:58:57 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: <3B2E6EA3.3DED7D95@earthlink.net>
Message-ID: <Pine.LNX.4.30.0106182257220.123-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When diffing 2.4.6-pre2 & pre3 I noticed some reiserfs code was changed.
This seems to cause VFS to panic via reiserfs.

Anyone else notice this?

Shawn.

