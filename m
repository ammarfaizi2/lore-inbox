Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUEVOGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUEVOGp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUEVOGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:06:45 -0400
Received: from main.gmane.org ([80.91.224.249]:10705 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261358AbUEVOGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:06:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: thomas weidner <3.14159@gmx.net>
Subject: nvidia not working on 2.6.6-bk5+ (x86-64) ?
Date: Sat, 22 May 2004 16:08:33 +0200
Message-ID: <pan.2004.05.22.14.08.33.254151@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e2f25a.dip.t-dialin.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the nvidia driver works fine on 2.6.6 but causes x to freeze on startup
with 2.6.6-bk5+ (haven't tried -bk[1234]). the nv driver works. i first
thought of the 4kstacks issue,but they are i386 only and the patch doesn't
affect x86-64. any ideas what might break nvidia?

