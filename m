Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUGKSpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUGKSpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGKSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:45:22 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:24003 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263979AbUGKSpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:45:20 -0400
Date: Sun, 11 Jul 2004 11:45:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: xfs-masters@oss.sgi.com, nathans@sgi.com, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix XFS uses of plain integer as NULL pointer
Message-ID: <20040711184503.GB25196@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0407111343260.1846@dsl-prvgw1cc4.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407111343260.1846@dsl-prvgw1cc4.dial.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 01:54:09PM +0300, Petri T. Koistinen wrote:

> This patch will fix XFS sparse warnings about using plain integer as
> NULL pointer.

These are already in the CVS tree.
