Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUHRSvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUHRSvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267499AbUHRSvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:51:35 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:61873 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267475AbUHRSve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:51:34 -0400
Date: Wed, 18 Aug 2004 11:51:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Aubin <daubin@actuality-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to have a Kernel & initrd in 1 binary?
Message-ID: <20040818185131.GB7749@taniwha.stupidest.org>
References: <E8F8DBCB0468204E856114A2CD20741F1A92F8@mail.local.ActualitySystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8F8DBCB0468204E856114A2CD20741F1A92F8@mail.local.ActualitySystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 02:32:07PM -0400, Dave Aubin wrote:

> Question, is there a way to bundle both the kernel and initrd in to
> just a kernel binary?

see the initramfs stuff in linux/usr


  --cw
