Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUAZP04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUAZP04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:26:56 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:58240 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S263679AbUAZP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:26:54 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.12728.624595.290060@jik.kamens.brookline.ma.us>
Date: Mon, 26 Jan 2004 10:26:48 -0500
To: Walt H <waltabbyh@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: MD Oops on boot with 2.6.2-rc1-mm3
In-Reply-To: <40146B68.6070007@comcast.net>
References: <40146B68.6070007@comcast.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, backing out md-06-allow-partitioning.patch fixed the MD Oops on
boot for me as well.  Thanks, Andrew and Walt, for the quick response!

  jik
