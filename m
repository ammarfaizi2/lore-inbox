Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWBLFGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBLFGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 00:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWBLFGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 00:06:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932212AbWBLFGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 00:06:53 -0500
Date: Sat, 11 Feb 2006 21:05:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in page_to_pfn in 2.6.16rc2-git9
Message-Id: <20060211210530.797c551d.akpm@osdl.org>
In-Reply-To: <20060212013328.GA11444@redhat.com>
References: <20060212013328.GA11444@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> I just hit this oops whilst trying to mount a corrupted vfat image
>  over loopback.

Repeatable?  Are you able to put the first meg or two of that vfat image on a
server somewhere?
