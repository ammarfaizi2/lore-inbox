Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVCQSqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVCQSqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVCQSqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:46:17 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:59546 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262393AbVCQSqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:46:16 -0500
Date: Thu, 17 Mar 2005 10:46:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jens Langner <Jens.Langner@light-speed.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.4 1/1] fs: new filesystem implementation VXEXT1.0
Message-ID: <20050317184601.GA15228@taniwha.stupidest.org>
References: <42399F54.1010108@light-speed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42399F54.1010108@light-speed.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 04:16:36PM +0100, Jens Langner wrote:

> The VXEXT filesystem is more or less a FAT16 based filesystem which
> was slightly modified by Wind River to allow the storage of more
> than 2GB data on a partition, as well as storing filenames with a
> maximum of 40 characters length.

Can this not then be folded into the existing vfat filesystem?
