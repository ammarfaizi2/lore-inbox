Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVICTjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVICTjF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVICTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 15:39:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751247AbVICTjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 15:39:04 -0400
Date: Sat, 3 Sep 2005 12:34:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-Id: <20050903123410.1320f8ab.akpm@osdl.org>
In-Reply-To: <20050903122126.GM3657@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<20050903122126.GM3657@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Hi Andrew,
> 
> it seems you dropped 
> schedule-obsolete-oss-drivers-for-removal-version-2.patch, but there's 
> zero mentioning of this dropping in the changelog of 2.6.13-mm1.
> 
> Can you explain why you did silently drop it?
> 

It spat rejects and when I looked at the putative removal date I just
didn't believe it anyway.  Send a rediffed one if you like, but
October 2005 is unrealistic.
