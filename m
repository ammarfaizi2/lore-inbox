Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264392AbTCXU2J>; Mon, 24 Mar 2003 15:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264393AbTCXU2I>; Mon, 24 Mar 2003 15:28:08 -0500
Received: from pat.uio.no ([129.240.130.16]:498 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264392AbTCXU2I>;
	Mon, 24 Mar 2003 15:28:08 -0500
To: Brian Dixon <dixonbp@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS locking routines do not invoke the filesystem lock operation
References: <OF6BB6BC0F.0A73968D-ON87256CF3.005E25D5-86256CF3.005E4972@us.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Mar 2003 21:39:06 +0100
In-Reply-To: <OF6BB6BC0F.0A73968D-ON87256CF3.005E25D5-86256CF3.005E4972@us.ibm.com>
Message-ID: <shsfzpcqz2t.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Brian Dixon <dixonbp@us.ibm.com> writes:

     > There is a problem with the getlk part of the original patch
     > for this.  Here is a more recent patch that includes the fix.

You've been told several times before why this approach is
unacceptable. Please stop resubmitting the same crap over and over
again.

Cheers,
  Trond
