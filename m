Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVD2DD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVD2DD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVD2DD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:03:27 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:53428 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261526AbVD2DDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:03:24 -0400
X-ORBL: [67.124.119.21]
Date: Thu, 28 Apr 2005 20:03:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Gilles Pokam <gpokam@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory
Message-ID: <20050429030313.GA10344@taniwha.stupidest.org>
References: <ba83582205042816522e2a7a93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba83582205042816522e2a7a93@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:52:21PM -0700, Gilles Pokam wrote:

> I have a special user application who needs to access any part of
> the kernel memory.

why & for what?

> My question is therefore how to make the whole memory accessible for
> that particular application ?

maybe /dev/kmem or /proc/kcore

it would help if you explain in more detail what you are trying to do
