Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSFTVgx>; Thu, 20 Jun 2002 17:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVgw>; Thu, 20 Jun 2002 17:36:52 -0400
Received: from pcp947161pcs.cstltn01.in.comcast.net ([68.58.145.243]:24330
	"EHLO mail.trelane.net") by vger.kernel.org with ESMTP
	id <S315472AbSFTVgv>; Thu, 20 Jun 2002 17:36:51 -0400
Date: Thu, 20 Jun 2002 16:36:48 -0500
From: Andrew D Kirch <Trelane@Trelane.Net>
To: Pradeep Padala <ppadala@cise.ufl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace vs /proc
Message-Id: <20020620163648.6d5e7955.Trelane@Trelane.Net>
In-Reply-To: <Pine.LNX.4.44.0206201708230.18125-100000@lin114-02.cise.ufl.edu>
References: <Pine.LNX.4.44.0206201708230.18125-100000@lin114-02.cise.ufl.edu>
Organization: Trelane's Network
X-Mailer: Sylpheed version 0.7.7cvs2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux already posesses modular support for a /proc filesystem, every distribution, and I believe the stock kernel config includes support for this under the filesystems section by default.

On Thu, 20 Jun 2002 17:10:43 -0400 (EDT)
Pradeep Padala <ppadala@cise.ufl.edu> wrote:

> Hi,
>    I have been trying to understand the features supported by linux ptrace 
> interface. In Solaris I think ptrace was replaced by /proc interface and 
> they claim it better. Are there any plans to do the same thing in linux? 
> 
> Thanks,
> Pradeep Padala
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
