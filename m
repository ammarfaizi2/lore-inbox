Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTBLRXM>; Wed, 12 Feb 2003 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBLRXM>; Wed, 12 Feb 2003 12:23:12 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:65244 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S266995AbTBLRXL>;
	Wed, 12 Feb 2003 12:23:11 -0500
Date: Wed, 12 Feb 2003 22:59:17 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: out of memory
Message-Id: <20030212225917.37d1768a.b_adlakha@softhome.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does my system logs have:
kernel : out of memory, killed process (xyz)

I have 256mb ram, and a huge swap partition which never gets used!
I am currently on 2.5.60 but i've been having this problem for a long time...
