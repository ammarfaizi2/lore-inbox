Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTD0Qu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTD0Qu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 12:50:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:41097 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263338AbTD0Qu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 12:50:58 -0400
Date: Sun, 27 Apr 2003 18:44:33 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Christopher Curtis <chris.curtis@riptidesoftware.com>
cc: Marc Giger <gigerstyle@gmx.ch>, <linux-kernel@vger.kernel.org>
Subject: Re: OOPS in airo.c [kernel BUG at skbuff.c:315!] 2.4 series
In-Reply-To: <3E92053C.2040106@riptidesoftware.com>
Message-ID: <Pine.SOL.4.30.0304271843220.14208-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Can you give a try at the latest version of the code at the CVS? Looks
like it solves the problem for at least some users. If it's at least an
improvement, I'd like to commit it to the kernel source for 2.4.21.

Thanks,
Javier Achirica

