Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbTGDUxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbTGDUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:53:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24970 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266179AbTGDUxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:53:42 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jul 2003 23:08:06 +0200 (MEST)
Message-Id: <UTC200307042108.h64L86P22656.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: scsi mode sense broken again
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From mdharm@ziggy.one-eyed-alien.net  Fri Jul  4 23:00:41 2003

	Do you still get the proper INQUIRY from 2.5.74?

Yes. But there is no need for you to worry.
This device just needs use_10_for_ms = 0.
When that is set all is well.

Andries
