Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWJTRyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWJTRyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWJTRyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:54:49 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:16594 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S964798AbWJTRys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:54:48 -0400
Date: Fri, 20 Oct 2006 19:54:45 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-ID: <20061020175445.GA9930@fiberbit.xs4all.nl>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net> <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net> <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 20th 2006 at 01:05 uur Eric W. Biederman wrote:

> Currently I don't expect anyone to find a match anywhere except in libpthreads,
> if you find any others please let me know.

/usr/bin/qemu-mipsel
/usr/bin/qemu-i386
/usr/bin/qemu-arm
/usr/bin/qemu-ppc
/usr/bin/qemu-mips
/usr/bin/qemu-armeb
/usr/bin/qemu-sparc

This is on Debian 'sid' x86-64.
-- 
Marco Roeland
