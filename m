Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWDEWxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWDEWxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWDEWx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:53:29 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8577 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932115AbWDEWx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:53:28 -0400
Date: Wed, 5 Apr 2006 15:55:35 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Valdis.Kletnieks@vt.edu,
       Kyle Moffett <mrmacman_g4@mac.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall
Message-ID: <20060405225535.GO15997@sorel.sous-sol.org>
References: <20060405223052.GE14724@sorel.sous-sol.org> <200604052246.k35Mkl6L010288@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052246.k35Mkl6L010288@wildsau.enemy.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Rosmanith (kernel@wildsau.enemy.org) wrote:
> good point. I was reading netlink.c and libaudit.c. obviously the wrong
> place ;-)

There's a decent README with the audit (userspace) source.  And the
actual message format is documented in source code only AFAIK.
