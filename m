Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRKUKzm>; Wed, 21 Nov 2001 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281706AbRKUKzc>; Wed, 21 Nov 2001 05:55:32 -0500
Received: from mons.uio.no ([129.240.130.14]:43450 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281700AbRKUKzR>;
	Wed, 21 Nov 2001 05:55:17 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS, Paging & Installing [was: Re: Swap]
In-Reply-To: <20011120135059.D4210@mikef-linux.matchmail.com>
	<200111210122.fAL1MwhC029913@sleipnir.valparaiso.cl>
	<20011120174622.A12996@mikef-linux.matchmail.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Nov 2001 11:55:07 +0100
In-Reply-To: <20011120174622.A12996@mikef-linux.matchmail.com>
Message-ID: <shs3d38xuk4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mike Fedyk <mfedyk@matchmail.com> writes:

     > On Tue, Nov 20, 2001 at 10:22:58PM -0300, Horst von Brand
     > wrote:
    >> Mike Fedyk <mfedyk@matchmail.com> said:
    >> > Do any newer versions of NFS fix the stateless server
    >> > problem?
    >>
    >> This is an _extremely_ hard problem: The server has to know
    >> somehow what the client thinks the state is... and either one
    >> (or both) may have been rebooted in between without the other
    >> one knowing.

     > Yep, but there are currently protocols (SMB) that do that, but
     > not necessarily in a unix way.

<Cough, choke>

  Exactly how, pray tell, does SMB cope with recovering the full state
info after client/server crashes?

Cheers,
   Trond
