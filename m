Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTJEJOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTJEJOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:14:38 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:64471 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S262827AbTJEJOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:14:37 -0400
Date: Sun, 5 Oct 2003 11:13:56 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: linux-kernel@vger.kernel.org
cc: Manfred Spraul <manfred@colorfullife.com>, pwaechtler@mac.com,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: POSIX message queues
Message-ID: <Pine.GSO.4.58.0310051047560.12323@ultra60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

For quite a long time there are two implementations of posix mqueues
around. I think it is time to decide at least if both of them have
chances of beeing applied to official kernel. So I would
like to know if Peter Waechtler's implementations is considered superior
or there is possible some discussion and further work on our
implementation is worthwhile.

There are a lot of differencies but if the most important one is use of
ioctl vs syscalls it can be changed (in fact our implementation loong time
ago used syscalls).

In another words: is our implementation in the position
of NGPT or better? ;-)

Regards
Krzysiek
