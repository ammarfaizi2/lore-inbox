Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTLEAqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLEAqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:46:54 -0500
Received: from codepoet.org ([166.70.99.138]:42475 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263785AbTLEAqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:46:53 -0500
Date: Thu, 4 Dec 2003 17:46:54 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Paul Adams <padamsdev@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205004653.GA7385@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 04, 2003 at 03:50:55PM -0800, Paul Adams wrote:
> Unless actual Linux code is incorporated in a binary
> distribution
> in some form, I don't see how you can claim
> infringement of the
> copyright on Linux code, at least in the U.S.

A kernel module is useless without a Linux kernel in which it can
be loaded.  Once loaded, it becomes not merely an adjunct, but an
integrat part of the Linux kernel.  Further, it clearly
"incorporate[s] a portion of the copyrighted work" since it
can only operate within the context of the kernel by utilizing
Linux kernel function calls.

To abuse your earlier metaphor, a kernel module is not comparable
to a programmatic musical composition inspired by a novel.  It is
better comparared with another novel with substantial similarity
in the theme, plot, sequence, settings, mood, dialogue, and
characters, with the same story being told, with trademarked
phrases and taglines, and that makes no sense whatsoever unless
you insert it's entire content over the top of page 450,
paragraph 4 (of the Linux "novel"), and which thereby changes 
the ending of the original book...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
