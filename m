Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271392AbTGQKZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbTGQKZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:25:39 -0400
Received: from d40.sstar.com ([209.205.179.40]:55804 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S271392AbTGQKZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:25:35 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: linux-kernel@vger.kernel.org
Subject: i2c-proc module
Date: Thu, 17 Jul 2003 05:40:26 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307170540.26684.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I2C wants an i2c-proc module, but I can't find where
to config it.  Something like this happens when I run sensors:

/proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
Make sure you have done 'modprobe i2c-proc'!

There was an i2c-proc module with lm_sensors 2.7.0.  What
am I missing?

Andy Johnson

