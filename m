Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTFKWjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTFKWjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:39:32 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:49073 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264156AbTFKWj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:39:28 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030611154122.55570de0.akpm@digeo.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055371983.1084.8.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 15:53:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 15:41, Andrew Morton wrote:

> You might try reverting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm8/broken-out/pci-init-ordering-fix.patch

Will do.

> Something oopsed I'd say.  You using radeon?  That seems pretty oopsy
> lately.

Yep, R7500.

	<b

