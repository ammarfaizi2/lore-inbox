Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUCOJVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCOJVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:21:34 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:45742 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262462AbUCOJUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:20:05 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 15 Mar 2004 10:16:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: tun/tap device + sysfs ...
Message-ID: <20040315091625.GB2084@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

eskarina kraxel ~# ls /sys/class/misc 
agpgart/  device-mapper/  hw_random/  mcelog/  net/tun/  nvram/  psaux/  rtc/
                                               ^^^^^^^
That looks very wrong ...

  Gerd

