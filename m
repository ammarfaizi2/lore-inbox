Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWJWKGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWJWKGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWJWKGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:06:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48278 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751867AbWJWKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:06:33 -0400
Subject: Re: [RFD][PATCH 1/2] sysctl: Allow a zero ctl_name in the middle
	of a sysctl table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com>
References: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 11:08:31 +0100
Message-Id: <1161598111.19388.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 01:22 -0600, ysgrifennodd Eric W. Biederman:
> I think this mechanism eases the pain enough that combined with a little
> disciple we can solve the reoccurring sysctl ABI breakage.

Agreed

> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Alan Cox <alan@redhat.com>

