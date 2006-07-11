Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWGKCJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWGKCJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWGKCJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:09:32 -0400
Received: from xenotime.net ([66.160.160.81]:22186 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964941AbWGKCJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:09:32 -0400
Date: Mon, 10 Jul 2006 19:12:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc1] Fix typos in /Documentation : 'A'
Message-Id: <20060710191218.d8ea2b6c.rdunlap@xenotime.net>
In-Reply-To: <20060710210755.abb2af5d.kernel1@cyberdogtech.com>
References: <20060710130549.ed48127a.kernel1@cyberdogtech.com>
	<20060710103433.37420ae2.rdunlap@xenotime.net>
	<20060710210755.abb2af5d.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 21:07:55 -0400 Matt LaPlante wrote:

> On Mon, 10 Jul 2006 10:34:33 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > On Mon, 10 Jul 2006 13:05:49 -0400 Matt LaPlante wrote:
> > 
> > > This patch fixes typos in various Documentation txts. This patch addresses some words starting with the letter 'A'.
> > > 
> > > Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
> > 
> > Hi,
> > Looks mostly good.  I think it would be OK to fix other typos
> > on the same lines as the patches... see below.
> 
> The updated patch below fixes two of the three issues you mentioned.  I don't know what you'd want done with the dead URL, that file doesn't have a whole lot else in it, and I don’t know what the new URL would be.  
> 
> I agree fixing other typos is a worthy cause, though currently I haven't really made any changes other than spelling for a couple reasons:
> 
> 1- I'm detecting the spelling errors by scripting with aspell and custom wordlists.  This method doesn't reveal grammatical errors often, and I'm not reading much of the actual documents except to get context for the spelling errors.  (I _am_ making all changes manually, not scripting the actual corrections).
> 
> 2- Spelling errors are really hard to dispute (except for some nationality issues)...things are either spelled wrong or right.  I would be more hesitant to change actual grammar where I could also unwittingly change the meaning of a technical document (which I often don't have indepth knowledge of to begin with).
> 
> I'll certainly be willing to more thoroughly read through and correct the docs later on (and I'm sure I could learn quite a bit in the process).  I thought this round of tackling the most obvious errors assisted by scripting would be a good way to get acquainted with the patching process.

OK, thanks.

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

---
~Randy
