Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280804AbRKLOe3>; Mon, 12 Nov 2001 09:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280808AbRKLOeT>; Mon, 12 Nov 2001 09:34:19 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:43531 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280804AbRKLOeM>; Mon, 12 Nov 2001 09:34:12 -0500
Message-ID: <3BEFDDBB.2090605@namesys.com>
Date: Mon, 12 Nov 2001 17:33:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in reiserfs w/2.4.7-10
In-Reply-To: <Pine.LNX.4.33.0111122233530.26293-100000@bad-sports.com> <3BEFBDE0.6080804@namesys.com> <3BEFC301.A92C64D4@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have now tested the latest Red Hat 7.2 kernel (2.4.7.-10) and it 
passes our regression tests, which means that it is indeed a reasonably 
stable kernel that I would be willing to put my home directory on if it 
was me and I wasn't using NFS on it.  (I used 2.4.5 on my laptop for 
months with no problem, and I would guess that it is as stable as that 
one, when we talk about stable, remember we mean stable for a a few 
hundred thousand users).  The latest Linus kernels will be more stable, 
and since Linux is still stabilizing, I would guess that using a recent 
kernel is going to remain a good idea for the next few months.  
 Apologies to Red Hat for relying on second hand reports, and for that 
reason advising users to go to a kernel I had more knowledge about. 
 Users using NFS should keep a watch on the recently found bug involving 
rename, I think a patch just came out recently, and I expect it will be 
going into the kernel soon.

Hans

