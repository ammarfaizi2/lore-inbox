Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVD0LBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVD0LBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVD0LBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:01:53 -0400
Received: from quechua.inka.de ([193.197.184.2]:32159 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261413AbVD0LBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:01:49 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200504271152.15423.rjw@sisk.pl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DQkId-0007AA-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 27 Apr 2005 13:01:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200504271152.15423.rjw@sisk.pl> you wrote:
> I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
> on AMD64.

Java  sux sometimes pretty much. Why it cannot be killed? is the system too
slow for X to responde, or have you been able to use kill -9? Maybe it
spawns threads too fast, try to "killall -9 java".

Greetings
Bernd
