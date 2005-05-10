Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVEJJRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVEJJRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVEJJRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:17:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:8878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261591AbVEJJRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:17:20 -0400
Date: Tue, 10 May 2005 02:16:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DVB patch 00/37] DVB updates for 2.6.12-rc4
Message-Id: <20050510021645.054982f5.akpm@osdl.org>
In-Reply-To: <20050510085210.GA17601@linuxtv.org>
References: <20050508184229.957247000@abc>
	<20050509180411.6cff1941.akpm@osdl.org>
	<20050510085210.GA17601@linuxtv.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
>  > In future, please try to gather Signed-off-by: lines for these
>  > contributions, thanks.
> 
>  How should we handle this with CVS? Should people add a
>  Signed-off-by: line to the CVS commit log?

That sounds reasonable.

> If they don't,
>  can I assume that "by policy" the Signed-off-by: line for
>  the committer is implicit?

I wouldn't do that.  S-O-B does imply that they have read, agreed to and
complied with the "Developer's Certificate of Origin" from
Documentation/SubmittingPatches.  That is not a thing which person A should
be asserting on person B's behalf.

> Or do I have to bug them to
>  mail me the Signed-off-by: line?

Yes please.
