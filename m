Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUKCVTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUKCVTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUKCVTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:19:05 -0500
Received: from mail.zmailer.org ([62.78.96.67]:45451 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261889AbUKCVRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:17:16 -0500
Date: Wed, 3 Nov 2004 23:17:14 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041103211714.GP12275@mea-ext.zmailer.org>
References: <41894779.10706@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41894779.10706@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 04:02:49PM -0500, Timothy Miller wrote:
> I'm just curious about why there seems to be so much work going into 
> supporting a wide range of GCC versions.  If people are willing to 
> download and compile a new kernel (and migrating from 2.4 to 2.6 is 
> non-trivial for some systems, like RH9), why aren't they willing to also 
> download and build a new compiler?


How about those other architectures, than i386 ?
Over the years I have learned, that while GCC may work OK in i386,
the same version used in SPARC does produce bad code.  This has
bitten me multiple times.


We weird people of other architechtures do tend to get "somewhat"
conservative over the years in finding, and finally staying with
a compiler that we have learned to work.   Multiple burned,
forever shy...

 /Matti Aarnio
