Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262466AbTCRPbd>; Tue, 18 Mar 2003 10:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbTCRPbd>; Tue, 18 Mar 2003 10:31:33 -0500
Received: from mail.ithnet.com ([217.64.64.8]:11272 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262466AbTCRPbb>;
	Tue, 18 Mar 2003 10:31:31 -0500
Date: Tue, 18 Mar 2003 16:42:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: kernel nfsd
Message-Id: <20030318164204.03eb683f.skraw@ithnet.com>
In-Reply-To: <15991.15327.29584.246688@charged.uio.no>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<15991.15327.29584.246688@charged.uio.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 16:31:43 +0100
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> >>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
>      > Hello Trond, hello all, can you explain what this means:
> 
>      > kernel: nfsd-fh: found a name that I didn't expect: <filename>
> 
>      > Should something be done against it, or is it simply
>      > informative?
> 
> The comment in the code just above the printk() reads
> 
>                 /* Now that IS odd.  I wonder what it means... */
> 
> Looks like you and Neil (and possibly the ReiserFS team) might want to
> have a chat...

I'm all for it. Who has a glue? I have in fact tons of these messages, it's a
pretty large nfs server.

-- 
Regards,
Stephan
