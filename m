Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWC3Ucm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWC3Ucm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC3Ucm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:32:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbWC3Ucl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:32:41 -0500
Date: Thu, 30 Mar 2006 12:32:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] DRM changes for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0603300650180.24125@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0603301232050.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603300650180.24125@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Dave Airlie wrote:
> 
> This contains the changes for the DRM I'd like in 2.6.17, mainly a new memory
> mapper and a safer r300 method for enabling pci ids... they now require a new
> Xorg driver..

Can you describe what that means more?

Does it mean that people with old X versions will lose hw acceleration? 
For which chips?

		Linus
