Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTKLRfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKLRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:35:18 -0500
Received: from www.willden.org ([63.226.98.113]:25775 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S263890AbTKLRfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:35:14 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: Re: What's the best way to instrument a driver?
Date: Wed, 12 Nov 2003 10:35:12 -0700
User-Agent: KMail/1.5.93
References: <200311121000.09229.shawn-lkml@willden.org>
In-Reply-To: <200311121000.09229.shawn-lkml@willden.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311121035.12402.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 10:00 am, Shawn Willden wrote:
> I can think of several ways to go about this, but I thought it might be a
> good idea to ask what would be the simplest/most flexible.

I just discovered a nifty thing called syscalltrack, which looks perfect.

Other suggestions are still welcome, though.

Thanks,

Shawn.
