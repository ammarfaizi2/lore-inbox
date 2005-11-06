Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKFSfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKFSfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 13:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVKFSfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 13:35:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24223 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750949AbVKFSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 13:35:02 -0500
Subject: Re: + v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
	added to -mm tree
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mchehab@brturbo.com.br, nshmyrev@yandex.ru,
       v4l@cerqueira.org
In-Reply-To: <20051106001249.48d3ade0.akpm@osdl.org>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 13:33:14 -0500
Message-Id: <1131301995.13599.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-06 at 00:12 -0800, Andrew Morton wrote:
> Well that didn't work.  The problem is that
> drivers/media/video/saa7134/saa7134-alsa.c doesn't appear to be wired
> up into the build system - it simply doesn't get compiled.
> 
> Please send a fix against next -mm? 

Also please send all ALSA related patches to
alsa-devel@lists.sourceforge.net for review.

Lee

