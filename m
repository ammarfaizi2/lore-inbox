Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265351AbUF2CGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUF2CGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUF2CGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:06:11 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:4824 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265351AbUF2CGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:06:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Jun 2004 19:05:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200406290155.i5T1tKYY030209@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406281904530.18879@bigblue.dev.mdolabs.com>
References: <200406290155.i5T1tKYY030209@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Roland McGrath wrote:

> Andrew Cagney discovered this problem while working on GDB.  I suspect this
> bug has always been there, but I've only actually tested current 2.6 kernels.

Roland, did you try with -mm kernels?



- Davide

