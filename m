Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKTJ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKTJ5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUKTJ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:57:45 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:530 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261482AbUKTJ5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:57:44 -0500
Date: Sat, 20 Nov 2004 10:57:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041120105740.1a238842.khali@linux-fr.org>
In-Reply-To: <20041118185612.GA20728@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

> Ok, let's try this (yet) again:

I'm sorry to insist be we really want this as a patch against
2.6.10-rc2. That's what Greg needs. As said earlier, the patch would
include the new adm1026.c file (obviously) as well as the necessary
changes to Kconfig and Makefile.

Other than that I'm fine with the code itself.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
