Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSD1T3r>; Sun, 28 Apr 2002 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314471AbSD1T3q>; Sun, 28 Apr 2002 15:29:46 -0400
Received: from mons.uio.no ([129.240.130.14]:61692 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S314469AbSD1T3p>;
	Sun, 28 Apr 2002 15:29:45 -0400
To: Dan Yocum <yocum@fnal.gov>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor NFS client performance on 2.4.18?
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no>
	<3CC9697C.41473ED9@fnal.gov>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Apr 2002 21:29:40 +0200
Message-ID: <shsofg3lizf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dan Yocum <yocum@fnal.gov> writes:

     > Trond, So, would I be correct in assuming that backing out the
     > linux-2.4.18-ping.dif patch would solve the problem in the
     > short term?

Not ping, but linux-2.4.18-rpc_tweaks.dif...

Cheers,
  Trond
