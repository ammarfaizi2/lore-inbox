Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFAFVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFAFVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFAFVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:21:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:36249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261225AbVFAFTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:19:35 -0400
Date: Tue, 31 May 2005 22:18:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: maurochehab@gmail.com, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Video for Linux Docummentation
Message-Id: <20050531221830.14e7463e.akpm@osdl.org>
In-Reply-To: <429D4459.2060206@m1k.net>
References: <429D2A7C.1080002@gmail.com>
	<429D4459.2060206@m1k.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
>  My fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch in -mm 
>  conflicts with the Video for Linux Documentation patch.

I got it all merged up OK.

>  I think you 
>  should just drop my patch, since it's in v4l cvs as card=28 (instead of 
>  card=27, in -mm).  I guess it will get into the kernel when the rest of 
>  v4l synchronizes.

Nah.  Please review next -mm and send any needed fixes.
