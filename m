Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTFPS4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTFPS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:56:46 -0400
Received: from pat.uio.no ([129.240.130.16]:29903 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264151AbTFPS4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:56:45 -0400
To: Ole Marggraf <marggraf@astro.uni-bonn.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21: NFS copy produces I/O errors
References: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Jun 2003 12:10:26 -0700
In-Reply-To: <Pine.LNX.4.55.0306162047140.6775@aibn99.astro.uni-bonn.de>
Message-ID: <shsllw1u9ct.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ole Marggraf <marggraf@astro.uni-bonn.de> writes:

     > Hello all.  As it seems (to me), there is some serious problem
     > in the NFS code of
     > 2.4.21 (and also of 2.4.20), causing I/O errors quite
     >        immediately.


This is a FAQ, has been discussed to death several times on this list,
and is all over the place in the archives.... 'man 5 nfs' and read
carefully the section on soft mounts.


Trond (I'm really sick of this question) Myklebust
