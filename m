Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbUJ1AhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUJ1AhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUJ1Aet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:34:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23268 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262669AbUJ1AdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:33:15 -0400
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
From: Lee Revell <rlrevell@joe-job.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0410271733440.10927@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500>
	 <417CE49B.4060308@yahoo.com.au>  <Pine.LNX.4.61.0410271733440.10927@p500>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 20:33:09 -0400
Message-Id: <1098923590.1514.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 17:40 -0400, Justin Piszcz wrote:
> Is there any chance Linus will freeze 2.6 and make the current development 
> tree 2.7?  It seems like ever since around 2.6.8 things have been getting 
> progressively worse (page allocation failures/nvidia 
> breakage/XFS-oops-when-copying-over-nfs-when-the-file-is-being-written-to)?

This not the kernel's problem when nvidia breaks.  The kernel developers
make NO EFFORT to support binary only modules!  Please, talk to nvidia
if this is a problem for you.

Lee

