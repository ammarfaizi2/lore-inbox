Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160281AbQG2K6y>; Sat, 29 Jul 2000 06:58:54 -0400
Received: by vger.rutgers.edu id <S160337AbQG2Kuc>; Sat, 29 Jul 2000 06:50:32 -0400
Received: from mayfly.plus.net.uk ([195.166.128.28]:23126 "HELO mayfly.force9.net") by vger.rutgers.edu with SMTP id <S160315AbQG2KtI>; Sat, 29 Jul 2000 06:49:08 -0400
Date: Fri, 28 Jul 2000 23:20:30 +0100
From: Adam Sampson <azz@gnu.org>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000728232030.C8868@gnu.org>
Reply-To: azz@gnu.org
Mail-Followup-To: Adam Sampson <azz@gnu.org>, linux-kernel@vger.rutgers.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <no.id>; from lk@tantalophile.demon.co.uk on Thu, Jul 27, 2000 at 07:03:57PM +0200
X-Homepage: http://cider.bnet-ibb.de/~azz/
X-Planation: RSA in 2 lines Perl: see http://dcs.ex.ac.uk/~aba/x.html
X-Munition-Export: print pack"C*",split/\D+/,`echo "16iII*o\U@{$/=$z;[(pop,pop,unpack"H*",<>)]}\EsMsKsN0[lN*1lK[d2%Sa2/d0<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<J]dsJxp"|dc`
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Jul 27, 2000 at 07:03:57PM +0200, Jamie Lokier wrote:
> But instead, how about a script: /lib/modules/VERSION/compile-module.
> The script would know where to find the kernel headers.  That could be
> /lib/modules/include for distributions, and /my/kernel/tree/include for
> folks who used `make modules_install' recently.

I'll second that suggestion. This kind of thing works very well indeed for
projects like Apache.

-- 

Adam Sampson
azz@gnu.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
