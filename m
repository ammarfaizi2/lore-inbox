Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTATBIe>; Sun, 19 Jan 2003 20:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTATBIe>; Sun, 19 Jan 2003 20:08:34 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:27264 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267738AbTATBId>;
	Sun, 19 Jan 2003 20:08:33 -0500
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15915.18967.933150.49658@charged.uio.no>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	 <15915.8496.899499.957528@charged.uio.no>
	 <1043016608.727.0.camel@tux.rsn.bth.se>
	 <15915.13242.291976.585239@charged.uio.no>
	 <1043021842.679.1.camel@tux.rsn.bth.se>
	 <15915.18967.933150.49658@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043025455.657.1.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 02:17:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 02:00, Trond Myklebust wrote:
> >>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:
> 
>      > With two added ; the patch compiled and produced this output:
> 
>      > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
>      > rpc_destroy_client: rpc_rmdir(/portmap/clnteb10c63c) failed
>      > with error -39 RPC: Couldn't create pipefs entry
>      > /portmap/clnteb10c63c, error -17 RPC: Couldn't create pipefs
>      > entry /portmap/clnteb10c63c, error -17 RPC: Couldn't create
>      > pipefs entry /portmap/clnteb10c63c, error -17
> 
> Hmm... Does the following help?

I'm afraid not, I get the exact same errormessage as without this patch.
(the one above)

Do you have working nfs-server?

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
