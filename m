Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWFVEME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWFVEME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWFVEMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:12:03 -0400
Received: from xenotime.net ([66.160.160.81]:24998 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750757AbWFVEMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:12:01 -0400
Date: Wed, 21 Jun 2006 21:14:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: kaigai@ak.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
Message-Id: <20060621211447.69ec0072.rdunlap@xenotime.net>
In-Reply-To: <20060621203550.b14e867a.akpm@osdl.org>
References: <449794BB.8010108@ak.jp.nec.com>
	<20060619234212.b95e5734.akpm@osdl.org>
	<4497A34C.2000104@ak.jp.nec.com>
	<449A0967.2020701@ak.jp.nec.com>
	<20060621203550.b14e867a.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:35:50 -0700 Andrew Morton wrote:

> On Thu, 22 Jun 2006 12:07:19 +0900
> KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
> 
> > The seriese of patches fixes some process accounting bugs.
> 
> OK, thanks for splitting those up.  A few patch-protocol things:
> 
> - Please make the email Subject: reflect the patch contents - all three
>   patches here were called "Re: Add pacct_struct to fix some pacct bugs."
> 
> - Please don't indent the changlogs by five spaces.  Start in column zero.
> 
> - Your email client performs space-stuffing, which corrupts the patches. 
>   I fixed them all by hand.
> 
>   I don't know if it's possible to prevent thunderbird from doing this
>   (my mozilla bugzilla record on this has to be three years old, and is
>   still open).  You might have to use text/plain attachments in the future.


tbird hints (works for me from oracle.com):

http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
and
http://lkml.org/lkml/2005/12/27/191
and
http://lists.osdl.org/pipermail/kernel-janitors/2006-June/006478.html

However, I guess there could be other things between the sender
and receiver that cause problems...

---
~Randy
