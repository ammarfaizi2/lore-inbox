Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbUKPS5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUKPS5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKPS5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:57:24 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:57860 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262120AbUKPSzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:55:51 -0500
Date: Tue, 16 Nov 2004 19:56:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.X - [RE-REVISED DRIVER]
Message-Id: <20041116195614.1634e3b0.khali@linux-fr.org>
In-Reply-To: <20041103164354.GB20465@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0beta2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Ok, let's try this again:

Fine with me. Care to send this again as a patch against 2.6.10-rc2?
This would include updates to drivers/i2c/chips/Makefile and
drivers/i2c/chips/Kconfig.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
