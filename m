Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277827AbRJ1Il4>; Sun, 28 Oct 2001 03:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277829AbRJ1Ilq>; Sun, 28 Oct 2001 03:41:46 -0500
Received: from pc3-redb4-0-cust245.bre.cable.ntl.com ([213.106.223.245]:2036
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S277827AbRJ1Ild>; Sun, 28 Oct 2001 03:41:33 -0500
Date: Sun, 28 Oct 2001 08:42:08 +0000
From: Mark Zealey <mark@zealos.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config
Message-ID: <20011028084208.A24803@itsolve.co.uk>
In-Reply-To: <Pine.LNX.4.21.0110271847240.12381-200000@Consulate.UFP.CX> <21646.1004231366@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21646.1004231366@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Oct 28, 2001 at 12:09:26PM +1100
X-Operating-System: Linux sunbeam 2.2.19 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 12:09:26PM +1100, Keith Owens wrote:

> On Sat, 27 Oct 2001 18:52:23 +0100 (BST), 
> Riley Williams <root@MemAlpha.CX> wrote:
> >The enclosed patch (against the raw 2.4.13 tree) adds a `make defconfig`
> >option that configures Linux with the default options obtained by simply
> >pressing ENTER to every prompt that comes up.
> >
> >Please apply.
> 
> Please don't.  You cannot blindly reply 'y' to all new options, it will
> hang on numbers and strings, the answer has to be context sensitive.
> There is already a patch for make allyes, allno, allmod and random (but
> valid) configs in kbuild 2.5.  That patch is context sensitive and can
> easily be extended with defconfig.

Pressing enter, not 'y'. There's a difference there, 'y' says yes and enter says
to accept the default

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
