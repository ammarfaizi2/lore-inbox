Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTG2KLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTG2KLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:11:31 -0400
Received: from aneto.able.es ([212.97.163.22]:710 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271375AbTG2KL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:11:29 -0400
Date: Tue, 29 Jul 2003 12:11:26 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729101126.GC29124@werewolf.able.es>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com> <20030729094820.GC28348@werewolf.able.es> <20030729095858.GB1286@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030729095858.GB1286@louise.pinerecords.com>; from szepe@pinerecords.com on Tue, Jul 29, 2003 at 11:58:58 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.29, Tomas Szepe wrote:
[...]
> 
> Does Mandrake also ship "stable" distributions w/ kernels compiled
using
> gcc 3.3-whatever or is that idiocy suse-specific?
> 

Tell me a distro that ships pristine www.kernel.org kernels o release
gcc's,
without any 'backported patch from xxx-1234 to correct PR1234'. What is
the difference between backporting a patch from 3.3.1-pre to 3.3, and
using 3.3.1-pre directly ? Ah, that you get less bug corrected.

And no, at least in my case, this is not a stable Mandrake, it is
Cooker,
the equivalent of RawHide. Latest stable shiped a kernel built with
3.2.3,
and current cooker builds kernels with 3.3.1. And bugs are discovered
and
fixed. What's bad ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is
like sex:
werewolf.able.es                         \           It's better when
it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
