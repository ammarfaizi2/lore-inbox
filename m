Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTIQP3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTIQP3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:29:49 -0400
Received: from math.ut.ee ([193.40.5.125]:17796 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262787AbTIQP3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:29:48 -0400
Date: Wed, 17 Sep 2003 18:09:35 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: USB IR Dongle Serial Driver broken
Message-ID: <Pine.GSO.4.44.0309171807100.19495-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried to compile USB IR Dongle Serial Driver, it breaks with

ir-usb.c: In function `ir_set_termios':
ir-usb.c:571: error: `B4000000' undeclared (first use in this function)

2.4.23-pre4 on sparc64

-- 
Meelis Roos (mroos@linux.ee)

