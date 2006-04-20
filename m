Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWDTSKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDTSKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWDTSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:10:22 -0400
Received: from pat.uio.no ([129.240.10.6]:30649 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751218AbWDTSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:10:21 -0400
Subject: Re: NFS bug?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Robert Merrill <grievre@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145551304.8136.5.camel@lade.trondhjem.org>
	 <b3be17f30604200953i652e14a2n908f1a066ffe4e7f@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
	 <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 14:10:13 -0400
Message-Id: <1145556613.8136.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.924, required 12,
	autolearn=disabled, AWL 1.08, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 11:02 -0700, Robert Merrill wrote:
> On 4/20/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > Given that you are reporting an error with copy_from_user, then it is
> > _definitely_ of interest to figure out what your glibc is telling the
> > kernel to copy.

Oh... and could you also send us the Oops/stack trace from the BUG_ON()?

Cheers,
  Trond

