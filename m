Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310322AbSCBFr6>; Sat, 2 Mar 2002 00:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310317AbSCBFrs>; Sat, 2 Mar 2002 00:47:48 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:7340 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S310324AbSCBFrb>; Sat, 2 Mar 2002 00:47:31 -0500
Subject: Re: dell inspiron and 2.4.18?
From: NyQuist <nyquist@ntlworld.com>
To: John Jasen <jjasen1@umbc.edu>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.31L.02.0203020004440.5865235-100000@irix2.gl.umbc.edu>
In-Reply-To: <Pine.SGI.4.31L.02.0203020004440.5865235-100000@irix2.gl.umbc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Mar 2002 05:32:38 +0000
Message-Id: <1015047158.4792.5.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-02 at 05:11, John Jasen wrote:
> 
> I have a Dell Inspiron 3700 running Redhat 7.2 with the latest updates,
> and I just upgraded to kernel 2.4.18. On random intervals, usually within
> about 10 minutes of usage, it hangs completely solid.
> 
> Enabling sysrq, recompiling 2.4.18 with kdb, and going to tinker with APIC
> tomorrow. Results, kernel .config, lspci -v, and so forth will be posted
> when I'm more awake.
> 
> Anyway, the short form: anyone else have any problems, or have I gone
> crazy again?
> 
Even though I wouldn't go so far as to call the 2.4 series stable (not
disrespecting the kernel hackers), i've been wondering whether my hours
spent in front of the computer are dulling my senses; i've had
intermittent lock-ups and 'soft'-locks, where hardly any processing is
done. I'm running 2.4.17 on a dell dimension. 
I wouldn't say you're crazy, but i'm getting nervous tics from sitting
in front of the computer screen all day, so what can I say :)
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
NyQuist | Matthew Hall -- NyQuist at ntlworld dot com --
http://NyQuist.port5.com
Sig: #define QUESTION ((bb) || !(bb))

