Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311497AbSCND1T>; Wed, 13 Mar 2002 22:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311498AbSCND1K>; Wed, 13 Mar 2002 22:27:10 -0500
Received: from [208.48.139.185] ([208.48.139.185]:13961 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S311497AbSCND1C>; Wed, 13 Mar 2002 22:27:02 -0500
Date: Wed, 13 Mar 2002 19:26:56 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
Message-ID: <20020313192656.B12472@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16lLTa-0008BN-00@the-village.bc.nu> <3C901105.5040605@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C901105.5040605@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 13, 2002 at 09:55:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 09:55:01PM -0500, Jeff Garzik wrote:
>
> Talk about a small world, I just found out today someone I know has been 
> maintaining the NGPT kernel patches :)
> 
> http://gtf.org/~dank/ngpt/

It even looks like kernel support is included 2.4.19-pre3:

http://oss.software.ibm.com/pthreads/

But don't see anything about it in any of the recent change logs...

-Dave
