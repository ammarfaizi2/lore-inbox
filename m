Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWBMJyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWBMJyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWBMJyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:54:37 -0500
Received: from mail.ccl.ru ([195.222.130.78]:55269 "EHLO mail.ccl.ru")
	by vger.kernel.org with ESMTP id S1751685AbWBMJyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:54:36 -0500
To: linux-kernel@vger.kernel.org
Subject: MTD for buffered IO
Message-Id: <E1F8ZhY-0001fy-00@porton.narod.ru>
From: "Victor Porton,,," <porton@ex-code.com>
Date: Mon, 13 Feb 2006 14:08:56 +0500
X-URL: http://porton.ex-code.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest to add kernel configuration/option to allow to use
an MTD device as a continuation of I/O buffers (for HDD).

One way to implement it would be to add the option for a swap partition/file to
allow to use this swap partition/file as I/O buffer for other device.
