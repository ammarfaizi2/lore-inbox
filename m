Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUDPLG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 07:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDPLG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 07:06:58 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:62469 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262907AbUDPLG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 07:06:56 -0400
Message-ID: <20040416110655.38439.qmail@web13907.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 16 Apr 2004 04:06:55 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: NFS_ALL patchsets updated for Linux-2.4.26...
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>A number of people have written to ask for updates of the 2.4.x
NFS_ALL
>patchsets which were unchanged since 2.4.23 or so. I haven't done this
>because the 2.4.23 patches should have applied fine to all kernels
>between 2.4.23 and the 2.4.26-pre series.
>
>Since we've now merged in several of the bugfixes that were already in
>NFS_ALL into Marcelo's kernel, I have put out an updated NFS_ALL for
>2.4.26. Please assume that it can be applied to any future 2.4.x
>kernels until further notice.
>
>Please also assume that, 2.4.x is feature-frozen. None of these
patches
>are therefore slated for inclusion into Marcelo's kernel. They are
only
>being provided in order to allow people who are currently relying on
>these features in their private 2.4.x builds to continue to use them.
>
>Please see
>
>http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.26/
>
>for further details.
Hi Trond,

 thanks for doing that update. Short qquestion: what happened to the
following two patches from the 2.4.23-rc1 set?

02-fix_commit - Patch is not marked "R", but all hunks fail.
06-fix_unlink - still applies (with offset) to 2.4.26

Thanks
Martin
PS: I sent this already directly to you, because the LKML messages seem
to come in very asynchronously since a few days.

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
