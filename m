Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVERSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVERSAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVERSA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:00:29 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:41700 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262272AbVERR7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:59:36 -0400
X-ORBL: [63.205.185.30]
Date: Wed, 18 May 2005 10:59:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gregory Brauer <greg@wildbrain.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <20050518175925.GA22738@taniwha.stupidest.org>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B7D7F.9000107@wildbrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 10:38:07AM -0700, Gregory Brauer wrote:

> May 18 02:59:47 violet kernel: xfs_iget_core: ambiguous vns: vp/0xf53f8ac8, invp/0xe49ccc4c

I'm pretty sure it's NFS that aggravates this --- can anyone recall
why?
