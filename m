Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTHGPTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTHGPRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:17:51 -0400
Received: from ares.sot.com ([212.149.98.215]:19466 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id S270203AbTHGPRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:17:35 -0400
Date: Thu, 7 Aug 2003 18:17:33 +0300 (EEST)
From: Yaroslav Popovitch <yp@sot.com>
To: linux-kernel@vger.kernel.org
Subject: mount current boot-device as root
Message-ID: <Pine.LNX.4.44.0308071807460.8989-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi! There was a patch, which allows to mount default boot device as root, 
without passing root= parameter to kernel.

Would you resend it to me, or provide me information how to detect the 
default boot device during kernel init (kernel API).

Cheers,YP

-
Mr. Yaroslav Popovitch yp@sot.com       - tel. +372 6419975
SOT Finnish Software Engineering Ltd.   - fax  +372 6419876
Kreutzwaldi 7-4, 10124  TALLINN         - http://www.sot.com
ESTONIA                                 - http://sotlinux.net

