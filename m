Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVCVDeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVCVDeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVCVDbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:31:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:7333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262527AbVCVCka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:40:30 -0500
Date: Mon, 21 Mar 2005 18:40:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050321184011.78808b8d.akpm@osdl.org>
In-Reply-To: <200503180754.21258.adaplas@hotpop.com>
References: <a44ae5cd05031416392e3addd5@mail.gmail.com>
	<200503180702.42247.adaplas@hotpop.com>
	<20050317154226.24c1f8f8.akpm@osdl.org>
	<200503180754.21258.adaplas@hotpop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> FYI, the original topic of this thread, though, was an oops in
>  i2c_add_driver() as mentioned in this thread:
> 
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=111076667232062&w=2
>   
>  Unfortunately, nobody can reproduce this oops.

Miles, are you still able to reproduce the i2c_add_driver() oops in
2.6.12-rc1 or 2.6.12-rc1-mm1?

Thanks.
