Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHNWNY>; Wed, 14 Aug 2002 18:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHNWNY>; Wed, 14 Aug 2002 18:13:24 -0400
Received: from pat.uio.no ([129.240.130.16]:2738 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315709AbSHNWNY>;
	Wed, 14 Aug 2002 18:13:24 -0400
To: Dax Kelson <dax@gurulabs.com>
Cc: torvalds@transmeta.com, "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>
Subject: Re: Will NFSv4 be accepted?
References: <Pine.LNX.4.44.0208141435210.30333-100000@mooru.gurulabs.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Aug 2002 00:17:10 +0200
In-Reply-To: <Pine.LNX.4.44.0208141435210.30333-100000@mooru.gurulabs.com>
Message-ID: <shs8z39dr15.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dax Kelson <dax@gurulabs.com> writes:

     > I for one would REALLY like to see NFSv4 (actually, Kerberized
     > NFSv4 is what I'm after).  I just finished setting up a
     > Kerberized Solaris NFS environment with home directories
     > automounted from the clients with strong user authentication.

     > Frankly, the stock (non-Kerberized) NFS security model blows.

Note: The RPCSEC_GSS (and accompanying kerberos) stuff is completely
independent of NFSv4. It is still in the process of being finalized,
but when it is, it will apply to NFSv2/v3 as well as v4.

RPCSEC_GSS is not an argument for NFSv4...

Cheers,
  Trond
