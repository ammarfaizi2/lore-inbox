Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWBGRO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWBGRO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBGRO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932163AbWBGROz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:14:55 -0500
Date: Tue, 7 Feb 2006 09:14:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
Message-Id: <20060207091427.3483c0fb.akpm@osdl.org>
In-Reply-To: <200602072154.13062.kernel@kolivas.org>
References: <200602071028.30721.kernel@kolivas.org>
	<200602071702.20233.kernel@kolivas.org>
	<43E8436F.2010909@yahoo.com.au>
	<200602072154.13062.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  Andrew I think I see why your G5 didn't see any benefit with swap prefetching.

No, this machine is x86 w/ 2GB.
