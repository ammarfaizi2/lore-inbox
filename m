Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbTGXHBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTGXHBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:01:15 -0400
Received: from fep02.swip.net ([130.244.199.130]:27077 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S271120AbTGXHBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:01:14 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: passing my own compiler options into linux kernel compiling
Date: Thu, 24 Jul 2003 09:16:17 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307240916.17530.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use gcc-3.3 and I would like compile my kernel with flags:

-O4 -march=pentium3 -mcpu=pentium3

Is there any way to do this?
Maybe there should be a possibility in menuconfig and xconfig for users
specify their own compiler options.

What do you think about this people?

Michal

