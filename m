Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbRF0Rpm>; Wed, 27 Jun 2001 13:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbRF0Rpc>; Wed, 27 Jun 2001 13:45:32 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:54033 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S265334AbRF0RpQ>;
	Wed, 27 Jun 2001 13:45:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 17:42:55 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9hd5uv$o95$2@abraham.cs.berkeley.edu>
In-Reply-To: <200106271357.IAA27308@tomcat.admin.navo.hpc.mil>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 993663775 24869 128.32.45.153 (27 Jun 2001 17:42:55 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Jun 2001 17:42:55 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard  wrote:
>2. Any penetration is limited to what the user can access.

Sure, but in practice, this is not a limit at all.

Once a malicious party gains access to any account on your
system (root or non-root), you might as well give up, on all
but the most painstakingly careful configurations.  That's why
chroot is potentially valuable.
