Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRKVMUU>; Thu, 22 Nov 2001 07:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKVMUK>; Thu, 22 Nov 2001 07:20:10 -0500
Received: from pat.uio.no ([129.240.130.16]:13239 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S277918AbRKVMUF>;
	Thu, 22 Nov 2001 07:20:05 -0500
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS, Paging & Installing [was: Re: Swap]
In-Reply-To: <E166mEL-0004sX-00@calista.inka.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Nov 2001 13:19:59 +0100
In-Reply-To: <E166mEL-0004sX-00@calista.inka.de>
Message-ID: <shsherngfps.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bernd Eckenfels <ecki@lina.inka.de> writes:

     > In article <shs3d38xuk4.fsf@charged.uio.no> you wrote:
    >> Exactly how, pray tell, does SMB cope with recovering the full
    >> state info after client/server crashes?

     > Not doing that is the better solution.

...and is why stateless filesystems are the norm. The claim that SMB
was different wasn't mine.

Cheers,
   Trond
