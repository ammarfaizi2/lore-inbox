Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUJYTLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUJYTLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJYTFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:05:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:6532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbUJYTEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:04:23 -0400
Date: Mon, 25 Oct 2004 12:02:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, jeremy@sgi.com, jes@sgi.com
Subject: Re: [PATCH] use mmiowb in qla1280.c
Message-Id: <20041025120223.3633ea4c.akpm@osdl.org>
In-Reply-To: <200410250918.01786.jbarnes@engr.sgi.com>
References: <200410211613.19601.jbarnes@engr.sgi.com>
	<200410211617.14809.jbarnes@engr.sgi.com>
	<1098634812.10906.38.camel@mulgrave>
	<200410250918.01786.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> > *** Warning: "mmiowb" [drivers/scsi/qla1280.ko] undefined!
> 
>  Only works in Andrew's tree until he pushes mmiowb to Linus.

I haven't been following this stuff at all closely and I need help
determining which patches should be pushed, and when.  Please.

