Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbRGCFtq>; Tue, 3 Jul 2001 01:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266440AbRGCFtf>; Tue, 3 Jul 2001 01:49:35 -0400
Received: from nwcst340.netaddress.usa.net ([204.68.23.85]:50643 "HELO
	nwcst340.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S266438AbRGCFt0> convert rfc822-to-8bit; Tue, 3 Jul 2001 01:49:26 -0400
Message-ID: <20010703054924.20200.qmail@nwcst340.netaddress.usa.net>
Date: 2 Jul 2001 23:49:24 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: kernel still resides in the root
X-Mailer: USANET web-mailer (34FM.0700.18.03B)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
                I just completed the full compilation. But there is one still
missing factor. I uncommented the INSTALL_PATH=/boot. But still the vmlinux
still resides in the directory where i compiled the kernel. Why is it so. What
to do if the kernel should be present in the boot directory. 
                  by
                        Blesson Paul
