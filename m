Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbTIOXx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTIOXx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:53:56 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:51593 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261708AbTIOXxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:53:55 -0400
From: jjluza <jjluza@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: test5-mm2: Unknown symbol when modprobe atm
Date: Tue, 16 Sep 2003 01:53:59 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309160153.59196.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to make test5-mm2 work on my gateway
I need to load module atm and pppoatm
these 2 modules return errors when I modprobe them.
dmesg says :
atm: Unknown symbol try_atm_clip_ops
pppoatm: Unknown symbol pppoatm_ioctl_set

