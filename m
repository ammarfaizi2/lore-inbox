Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWEOF6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWEOF6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 01:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEOF6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 01:58:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:42164 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932289AbWEOF6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 01:58:05 -0400
Subject: Re: Linux v2.6.17-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060511233955.0e8454fa.akpm@osdl.org>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
	 <20060511233955.0e8454fa.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 15 May 2006 15:57:54 +1000
Message-Id: <1147672674.21291.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 23:39 -0700, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok, I've let the release time between -rc's slide a bit too much again, 
> >  but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> 

I have at least one hot fix too pending confirmation by paulus (some
machine probe time that could harm various stuffs by mis-identifying
pseries at boot), and possibly another I'm still tracking (looks like
ide_unregister is broken but I'm still trying to isolate the bug,
definitely a regression though but might be a couple of kernels old)

Ben.
 

