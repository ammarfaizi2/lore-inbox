Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFFMLA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTFFMLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:11:00 -0400
Received: from mail.ithnet.com ([217.64.64.8]:19730 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261292AbTFFMK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:10:59 -0400
Date: Fri, 6 Jun 2003 14:24:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to turn off ide dma ...
Message-Id: <20030606142431.7ba80686.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for certain devices as boot-option in kernel 2.4.20 ?

E.g. you have three devices and want one of them (not all) to come up PIO
instead of DMA.
As using hdparm gives errors and delays for about 20-30 seconds on this device
it would be better to turn it off right from the beginning.

Regards,
Stephan
