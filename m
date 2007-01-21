Return-Path: <linux-kernel-owner+w=401wt.eu-S1751322AbXAUKQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXAUKQX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 05:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXAUKQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 05:16:23 -0500
Received: from lucidpixels.com ([66.45.37.187]:52078 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbXAUKQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 05:16:22 -0500
Date: Sun, 21 Jan 2007 05:16:21 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: 2.6.19.2 -> 2.6.20-rc5 libata regression
Message-ID: <Pine.LNX.4.64.0701210515510.3703@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19.2:
# hddtemp /dev/sda
/dev/sda: WDC WD740GD-00FLC0: 27C

2.6.20-rc5:
# hddtemp /dev/sda
/dev/sda: ATA WDC WD740GD-00FL: S.M.A.R.T. not available

