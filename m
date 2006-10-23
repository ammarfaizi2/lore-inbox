Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWJWXFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWJWXFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWJWXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:05:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:3295 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932366AbWJWXFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:05:11 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFD][PATCH 2/2] sysctl:  Implement CTL_UNNUMBERED
Date: Mon, 23 Oct 2006 23:15:15 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
References: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com> <m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232315.15634.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 09:25, Eric W. Biederman wrote:
> This patch takes the CTL_UNNUMBERD concept from NFS and makes
> it available to all new sysctl users.
>
> At the same time the sysctl binary interface maintenance documentation
> is updated to mention and to describe what is needed to successfully
> maintain the sysctl binary interface.

Good. I've been using 999 for my sysctls for quite some time.

-Andi 

>
