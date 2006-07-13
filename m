Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWGMPVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWGMPVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWGMPVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:21:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55742 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964778AbWGMPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:21:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: ak@suse.de, tytso@mit.edu, drepper@redhat.com, arjan@infradead.org,
       rdunlap@xenotime.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
Date: Thu, 13 Jul 2006 09:20:24 -0600
In-Reply-To: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	(Albert Cahalan's message of "Thu, 13 Jul 2006 01:00:38 -0400")
Message-ID: <m18xmx4jlz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> Normal sysctl works very well for FreeBSD. I'm jealous.
> They also have a few related calls that are very nice.

Of course as I recall the BSDs change reserve the right
to change all of their magic numbers periodically.

Eric
