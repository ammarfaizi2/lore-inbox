Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUINC6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUINC6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUINC55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:57:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52378 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269157AbUINC5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:57:05 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG at inode.c:1024 in 2.6.9-rc1-mm5
Date: Mon, 13 Sep 2004 19:57:02 -0700
User-Agent: KMail/1.7
References: <200409131933.47047.jbarnes@engr.sgi.com>
In-Reply-To: <200409131933.47047.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131957.02222.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2004 7:33 pm, Jesse Barnes wrote:
> Ok, I think this backtrace is actually legitimate (different, working
> hardware I hope) :)  I hit this while running aim7, about 20 min. into the
> run or so, probably at a few thousand users.  It was a 64p machine.  The
> machine stayed up and continued running aim7 until it was rebooted by the
> next user who had it reserved.

Umm... err... 2.6.9-rc1-mm5
