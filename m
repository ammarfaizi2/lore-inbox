Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbRCXBKR>; Fri, 23 Mar 2001 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbRCXBKI>; Fri, 23 Mar 2001 20:10:08 -0500
Received: from monza.monza.org ([209.102.105.34]:54788 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131526AbRCXBKB>;
	Fri, 23 Mar 2001 20:10:01 -0500
Date: Fri, 23 Mar 2001 17:09:01 -0800
From: Tim Wright <timw@splhi.com>
To: dhar <dhar@sawaal.com>
Cc: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010323170901.E2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: dhar <dhar@sawaal.com>, linux-smp@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103240004.FAA15257@email.sawaal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103240004.FAA15257@email.sawaal.com>; from dhar@sawaal.com on Sat, Mar 24, 2001 at 05:34:39AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm...
you don't really give enough information to make much of a guess.
I'd do the following:
Grab at least 2.2.18, or even better, get Alan's 2.2.19pre (which is almost
2.2.19 now, I believe), and build and install that kernel.

Now, if you run into the same problems, record the crash details, especially
if the kernels oopses, and then send the information (kernel version, output
of ksymoops if there is an oops, kernel .config used etc.) to the mailing list.

Tim

On Sat, Mar 24, 2001 at 05:34:39AM +0530, dhar wrote:
> Hi,
> 
> I am not a member of either of these lists and would appreciate if you could send your replies to me personally.
> 
> Now the problem:
> 
> I have an IBM Netfinity X330 server. Dual Processor (PIII 800). I compiled kernel 2.2.14 with SMP support. NFS was however compiled as a module. 
> 
> Now the problem is as follows:
> 
> Most of the times the machine just works fine. 
> But whenever there is heavy disk write activity it just hangs/crashes. Also this is when the SMP kernel is used. If I use the normal kernel then there is no problem. 
> 
> Could any one tell me what has to be done to prevent this from happening? 
> 
> Any help in this regard will be very much appreciated.
> 
> Once again, kindly reply to me personally as I am not a member of either of these lists.
>  
> Regards
> Dhar 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
