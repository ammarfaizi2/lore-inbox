Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUBZS0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUBZS0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:26:18 -0500
Received: from mail.artsci.net ([64.29.142.100]:65042 "EHLO jadsystems.com")
	by vger.kernel.org with ESMTP id S262862AbUBZS0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:26:16 -0500
Date: Thu, 26 Feb 2004 10:25:02 -0800
Message-Id: <200402261025.AA3240886544@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jim Deas" <jdeas0648@jadsystems.com>
Reply-To: <jdeas0648@jadsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel disables interrupts
X-Mailer: <IMail v6.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trouble shooting a new driver and have found a new
kernel item that makes trouble shooting a bit harder.
When I unload my test driver and before I can reload it
(reseting the interrut controls)the Kernerl disables
the chattering interrupt.
Once the kernel has disable a spurious interrupt is there
a way to get it back?

JD

