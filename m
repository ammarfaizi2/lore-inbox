Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277785AbRJRQMs>; Thu, 18 Oct 2001 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277791AbRJRQMi>; Thu, 18 Oct 2001 12:12:38 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:52613 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S277785AbRJRQMX>;
	Thu, 18 Oct 2001 12:12:23 -0400
Date: Thu, 18 Oct 2001 12:12:53 -0400
From: Mark Frazer <mark@somanetworks.com>
To: tushar korde <tushar_k5@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel
Message-ID: <20011018121253.A2929@somanetworks.com>
In-Reply-To: <20011018150903.23417.qmail@mailweb26.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018150903.23417.qmail@mailweb26.rediffmail.com>; from tushar_k5@rediffmail.com on Thu, Oct 18, 2001 at 03:09:03PM -0000
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The source for the 'strace' utility might be a good place to start
your project.  If you want to trace library calls instead of system
calls, try 'ltrace'.

tushar  korde <tushar_k5@rediffmail.com> [01/10/18 11:33]:
> 
> Sir
> 
> i am working on system call tracing.
> 
> i want to check the validity of the system
> 
> calls given by users how can i parse them. 
> 
> Does the linux O.S. also performs parsing ?
> 
> how can i make a grammar for the system
> 
> call parsing . 
> 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"we are like unbaked soma vessels"
