Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274177AbRIXVys>; Mon, 24 Sep 2001 17:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274170AbRIXVyi>; Mon, 24 Sep 2001 17:54:38 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:44558 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274177AbRIXVyY>; Mon, 24 Sep 2001 17:54:24 -0400
Message-ID: <3BAFABA9.9A8DD1B4@zip.com.au>
Date: Mon, 24 Sep 2001 14:54:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Troy Piper <jtp@dok.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.10
In-Reply-To: <20010924163546.C244@dok.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Troy Piper wrote:
> 
> Hey Andrew,
> 
> Any more progress on my journal_revoke BUG?  Strangely enough, I've been
> mounting the drives as ext2 to try and avoid the errors, but I *STILL* hit
> the BUG when untar'ing a large file, or compiling a large file (ie. kernel
> source), which is somewhat unnerving.

That should have been fixed in 0.9.9????
