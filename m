Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSDINOc>; Tue, 9 Apr 2002 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312311AbSDINOb>; Tue, 9 Apr 2002 09:14:31 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43451 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312212AbSDINOb>;
	Tue, 9 Apr 2002 09:14:31 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15538.59666.696452.273317@argo.ozlabs.ibm.com>
Date: Tue, 9 Apr 2002 23:13:54 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SET_PERSONALITY for static executables
In-Reply-To: <20020409.051545.78788265.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
>    From: Paul Mackerras <paulus@samba.org>
>    Date: Tue, 9 Apr 2002 22:10:30 +1000 (EST)
>    
>    The SET_PERSONALITY call which made a brief appearance in 2.4.18-rc4
>    (setting the personality for static binaries in fs/binfmt_elf.c) still
>    hasn't reappeared as of 2.4.19-pre6.  Here is the patch to put it back
>    in.
> 
> It's there in his current tree, where are you looking?

Oops, my mistake.  In fact we now have it twice in our PPC bk trees.
I blame bk. :)

Paul.
