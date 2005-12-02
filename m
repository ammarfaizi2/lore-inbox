Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVLBBep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVLBBep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbVLBBep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:34:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53004 "EHLO
	www262.sakura.ne.jp") by vger.kernel.org with ESMTP id S932710AbVLBBeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:34:44 -0500
Message-Id: <200512020134.jB21YQpJ046558@www262.sakura.ne.jp>
Subject: Wrong permission for kernel source tar ball !?
From: from-linux-kernel@i-love.sakura.ne.jp
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Date: Fri,  2 Dec 2005 10:34:26 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

"find -type f -perm 6" shows
extracted regular files are writable to everybody
for linux-2.6.14.tar.bz2 and later.

Something happened?
