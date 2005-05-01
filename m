Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVEAQvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVEAQvo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVEAQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 12:51:44 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:40464 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261687AbVEAQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 12:51:43 -0400
Date: Sun, 1 May 2005 18:52:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: I2C updates for 2.4.31-pre1
Message-Id: <20050501185236.2f76a5ba.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi all,

I have a number of I2C updates for 2.4.31-pre1 waiting. All are
backports from Linux 2.6 and are already present in i2c 2.9.1.

Individual patches follow, please apply.

Thanks,
-- 
Jean Delvare
