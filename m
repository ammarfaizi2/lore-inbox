Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHBQ6i>; Fri, 2 Aug 2002 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHBQ6c>; Fri, 2 Aug 2002 12:58:32 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22788 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315413AbSHBQ6a>; Fri, 2 Aug 2002 12:58:30 -0400
Message-ID: <3D4ABAE7.6000709@namesys.com>
Date: Fri, 02 Aug 2002 21:01:27 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Steve Lord <lord@sgi.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>	<1028246981.11223.56.camel@snafu>	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>	<1028297194.30192.25.camel@jen.americas.sgi.com>	<3D4AA0E6.9000904@namesys.com> <shslm7pclrx.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>     > 4 billion files is not enough to store the government's XML
>     > databases in.
>
>That's more of a glibc-specific bug. Most other libc implementations
>appear to be quite capable of providing a userspace 'readdir()' which
>doesn't ever use the lseek() syscall.
>
Interesting.  Thanks for the info.

-- 
Hans



