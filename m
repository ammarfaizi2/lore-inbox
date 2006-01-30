Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWA3UwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWA3UwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWA3UwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:52:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964978AbWA3UwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:52:17 -0500
Date: Mon, 30 Jan 2006 12:51:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][0/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
Message-Id: <20060130125137.509df714.akpm@osdl.org>
In-Reply-To: <43DE0A3A.4090404@sdl.hitachi.co.jp>
References: <43DE0A3A.4090404@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>
> I would like to propose the kprobe-booster and kretprobe-booster
>  to reduce overhead of kprobes and kretprobes.
>  They have already been discussed on the SystemTap ML.

Do you have performance testing results for this change?
