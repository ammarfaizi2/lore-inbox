Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317344AbSGIJLO>; Tue, 9 Jul 2002 05:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSGIJLN>; Tue, 9 Jul 2002 05:11:13 -0400
Received: from pat.uio.no ([129.240.130.16]:58051 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317344AbSGIJLM>;
	Tue, 9 Jul 2002 05:11:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New package of beta-level NFS client updates out for 2.4.19-rc1
Date: Tue, 9 Jul 2002 11:13:34 +0200
User-Agent: KMail/1.4.1
References: <200207081929.43742.trond.myklebust@fys.uio.no>
In-Reply-To: <200207081929.43742.trond.myklebust@fys.uio.no>
Cc: Charles Lever <Charles.Lever@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091113.34348.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 July 2002 19:29, Trond Myklebust wrote:

> The DIRECTIO patch has been removed pending a decision by Chuck on whether
> or not he wants to continue supporting it?

OK. Chuck Lever has confirmed that the NFS DIRECTIO patch will still be 
supported, so it has been reinstated as part of NFS_ALL. For further details 
again please see

     http://www.fys.uio.no/~trondmy/src/2.4.19-rc1/HEADER.html

Cheers,
  Trond
