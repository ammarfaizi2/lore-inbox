Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUIEUBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUIEUBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUIEUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:01:02 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:41853 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267180AbUIEUAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:00:14 -0400
Date: Sun, 5 Sep 2004 22:03:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use KERNELRELEASE
Message-ID: <20040905200317.GB16901@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <4139A443.4080704@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139A443.4080704@quark.didntduck.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 07:17:23AM -0400, Brian Gerst wrote:
> This patch changes several places where the kernel version string is put 
> together from it's components with $KERNELRELEASE.

A necessary addtion to LOCALVERSION - thanks.

Applied.

	Sam
