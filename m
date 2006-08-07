Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWHGQWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWHGQWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHGQWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:22:43 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:16571 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932203AbWHGQWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:22:42 -0400
Subject: Re: [patch] s390: hypfs comment cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
In-Reply-To: <20060807160327.GA6835@martell.zuzino.mipt.ru>
References: <20060807150807.GG10416@skybase>
	 <20060807160327.GA6835@martell.zuzino.mipt.ru>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 07 Aug 2006 18:22:40 +0200
Message-Id: <1154967760.23486.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 20:03 +0400, Alexey Dobriyan wrote:
> On Mon, Aug 07, 2006 at 05:08:07PM +0200, Martin Schwidefsky wrote:
> > [S390] hypfs comment cleanup.
> 
> Please, just delete file lines as they carry no additional info.

Hmm, it is common pratice to have the path of the source file in the
comment. If we decide to remove all these path from the comments, this
would be a perfect jobs for the kernel janitors. For now I want to keep
things consistent with the majority of the files in arch/s390.

One thing in favor of having the path in the comment: if you print the
file or copy it somewhere you still know where it came from. On the
other hand who prints files from the linux source tree ?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


