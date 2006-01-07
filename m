Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWAGJzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWAGJzM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWAGJzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:55:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18372 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932709AbWAGJzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:55:11 -0500
Date: Sat, 7 Jan 2006 01:51:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
Message-Id: <20060107015143.65477920.akpm@osdl.org>
In-Reply-To: <20060106132749.GC12131@stusta.de>
References: <20060106132749.GC12131@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
>  on i386.

This spews screenfuls of crap at me.  Crap which nobody is going to fix.

Sorry, nope.
