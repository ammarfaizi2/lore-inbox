Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWI1IfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWI1IfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWI1IfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:35:13 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:24294 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751775AbWI1IfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:35:11 -0400
Date: Thu, 28 Sep 2006 10:33:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olaf Hering <olaf@aepfle.de>
cc: sam@ravnborg.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add XARGS to toplevel Makefile
In-Reply-To: <20060928060224.GA16290@aepfle.de>
Message-ID: <Pine.LNX.4.61.0609281032420.21498@yvahk01.tjqt.qr>
References: <20060928060224.GA16290@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>run xargs with --no-run-if-empty to avoid random failures:

How about the short option, -r?




Jan Engelhardt
-- 
