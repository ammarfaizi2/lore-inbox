Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTBPWOI>; Sun, 16 Feb 2003 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBPWOI>; Sun, 16 Feb 2003 17:14:08 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:12200 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267721AbTBPWOG>; Sun, 16 Feb 2003 17:14:06 -0500
Message-ID: <3E500F74.2030002@blue-labs.org>
Date: Sun, 16 Feb 2003 17:23:48 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [OOPS] 2.5.53 NFS (rpc.mountd)
References: <3E4FEFEA.3030607@blue-labs.org> <15952.3676.932534.495560@notabene.cse.unsw.edu.au>
In-Reply-To: <15952.3676.932534.495560@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'been switching back and forth to find a reliable setup.  NFS has been 
touchy.  This report was provided mostly just for mention.

I'm putting .61 on the servers and clients as soon as it's done 
compiling per each machine.  .60 was pretty unstable for my dekstop with 
frequent BSOD (blank stare of deadness).

-d

Neil Brown wrote:

>On Sunday February 16, david+cert@blue-labs.org wrote:
>  
>
>>The below is what can happen infrequently after the following has occured:
>>
>>1) client loses love with server (df reports 1 for all filesystem stats)
>>2) admin runs 'exportfs -vra' on server
>>3) client gets love and server burps:
>>    
>>
>
>Can you produce this on a more recent kernel?  A lot has happened
>since 2.5.53.  I cannot point to some particular patch and say 'this
>fixes it', but I would be happier spending the time to chase it down
>if I knew it was still relevant.
>  
>

