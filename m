Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbTIIChc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTIIChc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:37:32 -0400
Received: from oumail.zero.ou.edu ([129.15.0.75]:34558 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id S263908AbTIICh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:37:26 -0400
Date: Mon, 08 Sep 2003 21:37:12 -0500
From: "Stephen M. Kenton" <skenton@ou.edu>
Subject: Re: Linux 2.6.0-test5 (compile stats)
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <3F5D3CD8.D2B291E6@ou.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD NSCPCD47  (Win98; I)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bzImage allmodconfig show 0 warning, but there seem to be
several "warning:" lines in the actual output.

> Note: the numbers look drastically better, but this is skewed
>       by the fact that CONFIG_CLEAN_COMPILE is now the default
>       for defconfig and allmodconfig.
> 
>                bzImage       bzImage        modules
>              (defconfig)  (allmodconfig) (allmodconfig)
> 
> 2.6.0-test5  0 warnings     0 warnings   305 warnings
>              0 errors       0 errors       5 errors

