Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbULGA52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbULGA52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULGA52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:57:28 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:49374 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261725AbULGA5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:57:25 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200412070120.05996.mbuesch@freenet.de>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041205234605.GF2953@stusta.de>
	 <1102349255.25841.189.camel@localhost.localdomain>
	 <200412070120.05996.mbuesch@freenet.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 06 Dec 2004 19:57:24 -0500
Message-Id: <1102381044.25841.230.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 01:20 +0100, Michael Buesch wrote:
> Wouldn't it be better to do a
> cond_syscall(sys_dsyscall)
> in kernel/sys_ni.c
> 

You learn something everyday!

Thanks,

-- Steve

