Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271363AbTG2Juf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTG2Jtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:49:52 -0400
Received: from aneto.able.es ([212.97.163.22]:28101 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271363AbTG2JsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:48:23 -0400
Date: Tue, 29 Jul 2003 11:48:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729094820.GC28348@werewolf.able.es>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030729093521.GA1286@louise.pinerecords.com>; from szepe@pinerecords.com on Tue, Jul 29, 2003 at 11:35:21 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.29, Tomas Szepe wrote:
> > On 07.29, Tomas Szepe wrote:
> >
> > Then why are we all calling current kernel 2.4.22 instead of
2.4.21.90 ?
> 
> WE aren't.
> 
> www.kerne.org:
> The latest stable version of the Linux kernel is: 2.4.21
> The latest prepatch for the stable Linux kernel tree is: 2.4.22-pre8

So what it this -------------------------------------------^^^^^^ ??
If people talks to you about 2.4.22, sure you understand at the first
glance tyey talk about the -pre of 2.4.22.

> The latest snapshot for the stable Linux kernel tree is: 2.4.21-bk20
> 
> > OK, the full name would be gcc-3.3.1-prerelease-of-20030720.
> 
> Yeah, it doesn't really surprise me it's all the same to Mandrake
people.
> 

What about Mandrake people ? Whats wrong with testing prerelease
software ?
I hope you just use release kernels, -pres are only for Mandrake people
;)
I would understand you if it were a bug in the compiler, if it it cried
against obviously correct code, but it just says
that the assembler syntax is old and you should change it.

Any ways, let it be. You just will have to hurry when real 3.3.1 or 3.4
gets out, and then two thousand people complaint instead of two couples.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is
like sex:
werewolf.able.es                         \           It's better when
it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
