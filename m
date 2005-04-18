Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVDRVgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDRVgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDRVgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:36:02 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:30478 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261187AbVDRVf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:35:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH 3/7] procfs privacy: misc. entries
Date: Mon, 18 Apr 2005 21:33:56 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d41944$qvq$1@abraham.cs.berkeley.edu>
References: <1113850012.17341.71.camel@localhost.localdomain> <20050418190552.GA26322@redhat.com> <1113853176.17341.101.camel@localhost.localdomain>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113860036 27642 128.32.168.222 (18 Apr 2005 21:33:56 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 18 Apr 2005 21:33:56 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Hernández  García-Hierro  wrote:
>El lun, 18-04-2005 a las 15:05 -0400, Dave Jones escribió:
>> This is utterly absurd. You can find out anything thats in /proc/cpuinfo
>> by calling cpuid instructions yourself.
>> Please enlighten me as to what security gains we achieve
>> by not allowing users to see this ?
>
>It's more obscurity than anything else. At least that's what privacy
>means usually.

Well, that's not what the word "privacy" means to me.  It seems to me
there are plenty of "privacy" issues that are real and legitimate and
have nothing to do with obscurity.

I agree with Dave Jones.  Security through obscurity makes no sense.
