Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266506AbRGQNrP>; Tue, 17 Jul 2001 09:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbRGQNrF>; Tue, 17 Jul 2001 09:47:05 -0400
Received: from mail.atl.external.lmco.com ([192.35.37.50]:28563 "HELO
	enterprise.atl.lmco.com") by vger.kernel.org with SMTP
	id <S266508AbRGQNq6>; Tue, 17 Jul 2001 09:46:58 -0400
Date: Tue, 17 Jul 2001 09:46:42 -0400
From: Chuck Winters <cwinters@atl.lmco.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Number of File descriptors
Message-ID: <20010717094642.A21464@atl.lmco.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010713095934.A6100@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010713095934.A6100@atl.lmco.com>; from chuck.winters@lmco.com on Fri, Jul 13, 2001 at 09:59:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank You all for the information

Chuck

On Fri, Jul 13, 2001 at 09:59:34AM -0400, Chuck Winters wrote:
> Hello All,
> 	My interest has been peaked by a recent email.  At one point, I heard two people speaking
> about how some database guy wanted to have 2000 open files(or something crazy like that).  
> They said that he must be crazy because the kernel does a sequential search through the open
> file descriptors.  Anyway, I read a posting an a mail list that someone wanted select to 
> select on 3000 files.  Alright, the question(Finally!):
> 		To have select() select on 3000 file descriptors, they must be open.  That's 3000 open
> 		files.  Will select be ultra slow trying to select on 3000 file descriptors?  Also, 
> 		what is the clarification on the kernel doing a sequential search through the open
> 		file descriptors?
> 
> Thanks In Advance,
> Chuck Winters
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
