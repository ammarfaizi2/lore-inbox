Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTG2J3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271351AbTG2J3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:29:03 -0400
Received: from aneto.able.es ([212.97.163.22]:63428 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271343AbTG2J3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:29:00 -0400
Date: Tue, 29 Jul 2003 11:28:57 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729092857.GA28348@werewolf.able.es>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030729045512.GM32673@louise.pinerecords.com>; from szepe@pinerecords.com on Tue, Jul 29, 2003 at 06:55:12 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.29, Tomas Szepe wrote:
> > [kwall@kurtwerks.com]
> > 
> > Quoth Tomas Szepe:
> > > > [lcapitulino@prefeitura.sp.gov.br]
> > > > 
> > > > Subject: Re: 2.6-test2: gcc-3.3.1 warning.
> > > 
> > > There's no such release as gcc-3.3.1.
> > 
> > A snapshot known as 3.3.1 was released on July 20.
> 
> Are you trying to argue that it's ok to call a snapshot
> a "name" an actual release will bear in the (not so distant)
> future?
> 

Oh, plz...
Then why are we all calling current kernel 2.4.22 instead of 2.4.21.90 ?
(thing that I would prefer...) ?
OK, the full name would be gcc-3.3.1-prerelease-of-20030720.
But the version comes from the gcc people, the distro did not choose it.
It is clear if it is the 3.4 or the 3.3.1 branch.
If gcc people has decided to deprecate a feature, live with it and
correct the kernel source. Same happened with multiline string literals.
This is no strange compiler, it is just the next gcc you will see.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is
like sex:
werewolf.able.es                         \           It's better when
it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
