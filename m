Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRKVXta>; Thu, 22 Nov 2001 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281819AbRKVXtU>; Thu, 22 Nov 2001 18:49:20 -0500
Received: from ns01.netrox.net ([64.118.231.130]:29364 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281818AbRKVXtI>;
	Thu, 22 Nov 2001 18:49:08 -0500
Subject: Re: [PATCH] Documentation/Changes
From: Robert Love <rml@tech9.net>
To: Dmitri Popov <popov@krista.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0111221003100.24032-100000@popov.krista.ru>
In-Reply-To: <Pine.LNX.4.31.0111221003100.24032-100000@popov.krista.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 22 Nov 2001 18:47:52 -0500
Message-Id: <1006472875.1331.2.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 02:08, Dmitri Popov wrote:

> Thank you for this information. According to documentation, new
> quota-tools know about both old and new quota formats, so I don't need to
> downgrade now. My personal part of the problem is solved. But I can't
> didn't find any information about minimum quota-tools version in
> neither Linus's, nor Alan's kernel. Although versions of other utilities
> are listed in Changes.

Perhaps you should add it, then :)

Since we are in Linus's tree, it would just mean mentioning the earliest
version that supports the standard quotas (and has no evil bugs and what
not).  You could mention the first version that adds support for 32-bit
quotas I suppose, too.

	Robert Love

