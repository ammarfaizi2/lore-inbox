Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDOUhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUDOUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:37:55 -0400
Received: from zeus.city.tvnet.hu ([195.38.100.182]:2181 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP id S262175AbUDOUhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:37:54 -0400
Subject: off:latest binary nvidia driver won't compile with 2.6.6-rc1
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082061685.5837.2.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Thu, 15 Apr 2004 22:41:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The outer module patch for .temp creation didn't solve the problem,
compilation stops with can't fine Modules.synver in /usr/src/linux-
2.6.6-rc1.

Paco
