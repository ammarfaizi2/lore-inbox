Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271371AbTG2J7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTG2J7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:59:36 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:28301 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271371AbTG2J7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:59:32 -0400
Date: Tue, 29 Jul 2003 11:58:58 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729095858.GB1286@louise.pinerecords.com>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com> <20030729094820.GC28348@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729094820.GC28348@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jamagallon@able.es]
> 
> > The latest prepatch for the stable Linux kernel tree is: 2.4.22-pre8
> 
> So what it this -------------------------------------------^^^^^^ ??

Does your screen only have 63 columns?

> If people talks to you about 2.4.22, sure you understand at the first
> glance tyey talk about the -pre of 2.4.22.

Try submitting a bug report that reads "there's this and this problem
in 2.4.22."  One of the first questions you are bound to be asked is
"could you clarify the version you're seeing the problem with?"

> I hope you just use release kernels, -pres are only for Mandrake people ;)

Does Mandrake also ship "stable" distributions w/ kernels compiled using
gcc 3.3-whatever or is that idiocy suse-specific?

> I would understand you if it were a bug in the compiler, if it it cried
> against obviously correct code, but it just says
> that the assembler syntax is old and you should change it.

So far I said nothing about the problem itself; all the time I'm merely
trying to point out that it's dreadfully unreasonable to pretend that
there's a gcc 3.3.1.

> Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))

Right.

-- 
Tomas Szepe <szepe@pinerecords.com>
