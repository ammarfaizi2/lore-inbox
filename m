Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUBWAgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUBWAgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:36:03 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:50835 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261295AbUBWAf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:35:57 -0500
Subject: Re: 2.4.25 and xfs compile errors
From: R Dicaire <rdicair@comcast.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040222234117.GB3213@frodo>
References: <1077423230.1589.8.camel@ws.rdb.linux-help.org>
	 <20040222234117.GB3213@frodo>
Content-Type: text/plain
Organization: 
Message-Id: <1077496567.1589.13.camel@ws.rdb.linux-help.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Feb 2004 19:36:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-22 at 18:41, Nathan Scott wrote:
> > gcc version 3.2.3

> 
> Looks like your compiler is getting confused by routines
> that have been declared "static inline" in a header - you
> probably need to upgrade/downgrade your compiler.

I have compiled the same kernel, on another slackware 9.1 box,
same version gcc, with no xfs support, worked fine.

Any other ideas?

