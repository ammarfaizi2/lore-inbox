Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUEaDid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUEaDid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 23:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUEaDid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 23:38:33 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:31442 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264524AbUEaDi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 23:38:27 -0400
Date: Sun, 30 May 2004 20:38:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Ooops w/2.6.7-rc2 & XFS
Message-ID: <20040531033821.GA24009@taniwha.stupidest.org>
References: <20040531023225.93772.qmail@web90002.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531023225.93772.qmail@web90002.mail.scd.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 07:32:25PM -0700, Phy Prabab wrote:

> nfsd: non-standard errno: -990

XFS has detected corruption.  Umount and run xfs_repair.


  --cw
