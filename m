Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUGVANA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUGVANA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUGVAM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 20:12:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:17132 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266781AbUGVAM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 20:12:58 -0400
Date: Wed, 21 Jul 2004 17:12:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: L A Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.6.7-vanilla-SMP kernel: pagebuf_get: failed to lookup pages
Message-ID: <20040722001224.GC30595@taniwha.stupidest.org>
References: <40FF0479.6050509@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FF0479.6050509@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:04:09PM -0700, L A Walsh wrote:

> Any idea what this message means?

it means "try the CVS tree" (i think hch fixed this and it's in CVS
but not mainline)


  --cw
