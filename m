Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSLEOqu>; Thu, 5 Dec 2002 09:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSLEOqu>; Thu, 5 Dec 2002 09:46:50 -0500
Received: from [213.171.53.133] ([213.171.53.133]:41220 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S261339AbSLEOqu>;
	Thu, 5 Dec 2002 09:46:50 -0500
Date: Thu, 5 Dec 2002 17:56:54 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
Message-Id: <200212051456.gB5Eusbv000881@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50] Keyboard dying
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       After some X <-> back switches keyboard stops doing anything.
       2.5.50 + preempt enabled, X 4.2.1-debian-unstable.

showkey started using gpm tells that the keys actually are pressed and
processed by the kernel.
Although even alt+sysrq+whatever do not make any effect.

regards, Samium Gromoff
