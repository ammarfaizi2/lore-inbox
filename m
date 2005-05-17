Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVEQMjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVEQMjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 08:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEQMjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 08:39:21 -0400
Received: from 4.34.76.83.cust.bluewin.ch ([83.76.34.4]:21108 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261430AbVEQMjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 08:39:18 -0400
Date: Tue, 17 May 2005 14:35:49 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: ALSA make menuconfig Help description missing
Message-ID: <20050517123549.GA2378@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
Sound Architecture and

v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
Sound Architecture -> Advanced Linux Sound Architecture

are missing their help descriptions:

"There is no help available for this kernel option."

Therefore the user is unable to determine how to use this subsystem
at all.

CL<
