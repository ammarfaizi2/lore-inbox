Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWBXMMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWBXMMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWBXMMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:12:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932119AbWBXMMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:12:30 -0500
Date: Fri, 24 Feb 2006 04:11:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: gthaker@atl.lmco.com, linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using
 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-Id: <20060224041145.5bcdbc97.akpm@osdl.org>
In-Reply-To: <20060223205851.GA24321@elte.hu>
References: <43FE134C.6070600@atl.lmco.com>
	<20060223205851.GA24321@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> To figure out the true overhead of both kernels, could you try the 
>  attached loop_print_thread.c code
>

http://www.zip.com.au/~akpm/linux/#zc  <- better ;)
