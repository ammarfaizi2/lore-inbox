Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbSLRK44>; Wed, 18 Dec 2002 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267226AbSLRK44>; Wed, 18 Dec 2002 05:56:56 -0500
Received: from pat.uio.no ([129.240.130.16]:45229 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267224AbSLRK44>;
	Wed, 18 Dec 2002 05:56:56 -0500
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with NFSv3 kernel 2.5.52 server, 2.4.20 client. (server x86 linux, clientsparclinux)
References: <Pine.LNX.4.43.0212181026370.25931-100000@cibs9.sns.it>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Dec 2002 12:04:46 +0100
In-Reply-To: <Pine.LNX.4.43.0212181026370.25931-100000@cibs9.sns.it>
Message-ID: <shssmwvoaep.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == venom  <venom@sns.it> writes:

     > On the server I could not find any error message, while on the
     > sparclink client I found:

     > Dec 17 18:08:16 storm kernel: call_verify: server accept
     > status: 1 Dec 17 18:08:16 storm last message repeated 2 times
     > Dec 17 18:08:16 storm kernel: RPC: garbage, exit EIO Dec 17

What mount options are you using? Is it a 'tcp' mount?

Are other clients able to access the server without the above problem?

Cheers,
  Trond
