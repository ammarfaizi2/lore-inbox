Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVBXIAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVBXIAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVBXH5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:57:50 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:16019 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262121AbVBXH4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:56:07 -0500
Subject: Re: [PATCH 1/13] timestamp fixes
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050224074624.GA7847@elte.hu>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site> <20050224074624.GA7847@elte.hu>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 18:56:01 +1100
Message-Id: <1109231761.5177.115.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 08:46 +0100, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > 1/13
> > 
> 
> ugh, has this been tested? It needs the patch below.
> 

Yes. Which might also explain why I didn't see -ve intervals :(
Thanks Ingo.

In the context of the whole patchset, testing has mainly been
based around multiprocessor behaviour so this doesn't invalidate
that.



