Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVF0VL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVF0VL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVF0VJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:09:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261796AbVF0VEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:04:55 -0400
Date: Mon, 27 Jun 2005 14:05:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] Documentation/feature-removal-schedule.txt in date
 order
Message-Id: <20050627140549.1fbaf3e7.akpm@osdl.org>
In-Reply-To: <20050627131633.62af898b.rdunlap@xenotime.net>
References: <20050627131633.62af898b.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap <rdunlap@xenotime.net> wrote:
>
> a.  arrange feature-removal items in date order

I'm not sure that this will be very successful.  Every man and his dog is
patching this file - it's a major source of rejects for me and I have a
habit of sticking new records into random places just to avoid rejects
against changes coming in from other trees.
