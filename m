Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUANQoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUANQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:44:13 -0500
Received: from userk185.dsl.pipex.com ([62.188.58.185]:44992 "HELO
	userk185.dsl.pipex.com") by vger.kernel.org with SMTP
	id S262123AbUANQoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:44:13 -0500
From: "Sean Hunter" <sean@uncarved.com>
Date: Wed, 14 Jan 2004 16:44:11 +0000
To: linux-kernel@vger.kernel.org
Subject: Soekris/udev 2.6 success story
Message-ID: <20040114164411.GA13847@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6 has been working great on my soekris net4801 (see
http://www.soekris.com/net4801.htm) dns server/firewall and since it
uses a compact flash card for root, I implemented /dev on tmpfs using
udev, and it all works using the sysfs patches in the mm series kernels.

I've just rebooted using 2.6.1-mm3 (I'll let you know if there are any
problems).

Sean
