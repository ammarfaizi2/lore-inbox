Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWDEW2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWDEW2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWDEW2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:28:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13185 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932108AbWDEW2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:28:47 -0400
Date: Wed, 5 Apr 2006 15:30:52 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Valdis.Kletnieks@vt.edu, Kyle Moffett <mrmacman_g4@mac.com>,
       Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall
Message-ID: <20060405223052.GE14724@sorel.sous-sol.org>
References: <200604052036.k35KaQXk021296@turing-police.cc.vt.edu> <200604052147.k35LlOpK010229@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052147.k35LlOpK010229@wildsau.enemy.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Rosmanith (kernel@wildsau.enemy.org) wrote:
> anyway, the manpage describes how auditd/libaudit works - not how it has been
> implemented/how it communicates with the kernel.
> I want to know how it works "under the hood", not just how to use it.

Then grab the source, and read its READMEs.

> LSM depends
> on CONFIG_AUDIT* (this is correct, isn't it?)

No.
