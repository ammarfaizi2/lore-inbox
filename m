Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUKTLz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUKTLz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKTLz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:55:56 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:4100 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262745AbUKTLy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:54:27 -0500
Date: Sat, 20 Nov 2004 12:54:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: I2C updates for 2.4.28
Message-Id: <20041120125423.42527051.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi all,

I have a number of I2C updates for 2.4.28 waiting. All of them are
rather small and independent, gathered during the 2.4.27 cycle as user
reported problems and we fixed them in i2c CVS.

Individual patches follow, please apply.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
