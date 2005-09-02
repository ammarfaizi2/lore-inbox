Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVIBNlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVIBNlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIBNlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:41:11 -0400
Received: from codepoet.org ([166.70.99.138]:32444 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751311AbVIBNlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:41:10 -0400
Date: Fri, 2 Sep 2005 07:41:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050902134108.GA16374@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Kyle Moffett <mrmacman_g4@mac.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 01, 2005 at 11:00:16PM -0400, Kyle Moffett wrote:
> A while ago there was a big discussion about splitting out the
> userspace-accessible portions of the kernel headers into a separate
> directory, "kabi", "kernel-abi", "linux-abi", or a half-dozen other
> suggestions.  Linus sprinkled a bit of holy-penguin-pee on the idea,
> but nothing ever really happened after that.

Have you seen the linux-libc-headers:
    http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
which, while not an official part of the kernel, do a pretty
good job...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
