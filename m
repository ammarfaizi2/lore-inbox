Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSA1T3E>; Mon, 28 Jan 2002 14:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSA1T2z>; Mon, 28 Jan 2002 14:28:55 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:32496
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S289338AbSA1T2k>; Mon, 28 Jan 2002 14:28:40 -0500
Date: Mon, 28 Jan 2002 19:28:36 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <20020128192836.GB28473@itsolve.co.uk>
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com> <3C54D1CB.23664.50D4C3@localhost> <E16VHH9-0000Ba-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16VHH9-0000Ba-00@starship.berlin>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 08:17:06PM +0100, Daniel Phillips wrote:

> > I also tried this header in a regular application. This failed to return 
> > the modulus although it works in a module.
> > 
> > Is this asm syntax documented anywhere ? 
> 
> It's painful, isn't it?  And no, I don't know where it's documented.

I've had these docs for some time, can't remember where I got them from:
http://pkl.net/~mark/GCC_INLINE_ASM_HOWTO
http://pkl.net/~mark/rmiyagi-inline-asm.txt

They're quite good. the rest is experiance..

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
