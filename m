Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTIPF3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 01:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTIPF3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 01:29:48 -0400
Received: from mail1.nucleus.com ([207.34.101.2]:46610 "EHLO mail.nucleus.com")
	by vger.kernel.org with ESMTP id S261773AbTIPF3s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 01:29:48 -0400
Message-ID: <0e851eca491344bebdb7b1a70a1bc608.jeremyjin@nucleus.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
From: "" <jeremyjin@nucleus.com>
To: linux-kernel@vger.kernel.org
Subject: How to know current Kernel Configuration?
Date: Mon, 15 Sep 2003 23:29:46 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose I have redhat Linux 9.0 installed which comes with kernel 2.4.20, and I want to compile 2.4.22 by myself. And I want to keep most configuration settings because I think these settings should be pretty good, how can I know the current configuration of the current kernel? I know make has a option "make oldconfig", but seems like it is the old configuration of the last times "make", not the one of current running kernel. 

Is there any command to list all current running linux kernel configuration which is used to compile that version?

Thanks in advance!

