Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJYPIj>; Thu, 25 Oct 2001 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRJYPIa>; Thu, 25 Oct 2001 11:08:30 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:53688 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S274749AbRJYPIN>;
	Thu, 25 Oct 2001 11:08:13 -0400
Date: Thu, 25 Oct 2001 17:08:46 +0200
From: David Weinehall <tao@acc.umu.se>
To: Frontgate Lab <mdiwan@wagweb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Message-ID: <20011025170845.F25701@khan.acc.umu.se>
In-Reply-To: <3BD8222C.E741D186@wagweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BD8222C.E741D186@wagweb.com>; from mdiwan@wagweb.com on Thu, Oct 25, 2001 at 10:31:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:31:08AM -0400, Frontgate Lab wrote:
> Just out of a need to know things :)
> 
> What compiler do Alan Cox and Linus use to create the 2.4 series
> kernels?
> 
> I am currently using RedHat's compiler gcc-2.96-85 and have been told
> not to do so because it "breaks things" .

This is likely due to the fact that some people are still living with
the misconception that all gcc-2.96 releases are buggy. They are not;
only early versions are.

gcc-2.95.[34] and gcc-2.96-(newer versions) are viable choices if you
want a working kernel. Some other versions might work, but then again,
they might not :-)
> So far it has not broken anything, but then again i am compiling kernels
> for use on my RedHat Distributions.
> 
> The question would be .. how hard is it going to be for me to upgrade to
> gcc 3 +  and  will i get any benefit from it?  WillI loose any
> advantages that i currently do have?

At the moment, gcc3 doesn't work too well with the kernel, and you won't
get any large benefit.

> Or can i still get what i need from compiling 2.4.12 or 2.4.13 with the
> compiler I have now?

Yes.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
