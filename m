Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUDPQ4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbUDPQ4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:56:22 -0400
Received: from web13910.mail.yahoo.com ([216.136.172.95]:44925 "HELO
	web13910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263419AbUDPQ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:56:18 -0400
Message-ID: <20040416165617.82005.qmail@web13910.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Fri, 16 Apr 2004 09:56:17 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: NFS_ALL patchsets updated for Linux-2.4.26...
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> thanks for doing that update. Short qquestion: what happened to the
>> following two patches from the 2.4.23-rc1 set?
>>
>> 02-fix_commit - Patch is not marked "R", but all hunks fail.
>
>See the 2.4.26 changelog. This patch is already in the main tree.

 seems my quick check for patch inclusion (just do a "patch --dry-run"
and look for reverted warnings) failed  here. Good to here that this is
in.

>> 06-fix_unlink - still applies (with offset) to 2.4.26
>
>Whoops. I missed that one... I thought I'd sent it in too, but
>apparently not.
>
>I'll update the NFS_ALL...

 Happy to help.

Cheers
Martin

PS: Did I tell you to check your "DEC Links" on your home page :-)


=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
