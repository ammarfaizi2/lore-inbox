Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbTH0VO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbTH0VO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:14:57 -0400
Received: from aneto.able.es ([212.97.163.22]:56246 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263670AbTH0VOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:14:54 -0400
Date: Wed, 27 Aug 2003 23:14:51 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: herbert@13thfloor.at
Cc: Peter Osterlund <petero2@telia.com>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030827211451.GA26595@werewolf.able.es>
References: <20030811085508.GH31810@waste.org> <m2vfsk16iv.fsf@p4.localdomain> <20030827210830.GF26817@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030827210830.GF26817@www.13thfloor.at>; from herbert@13thfloor.at on Wed, Aug 27, 2003 at 23:08:30 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.27, Herbert Pötzl wrote:
> On Tue, Aug 26, 2003 at 10:57:28PM +0200, Peter Osterlund wrote:
> > Matt Mackall <mpm@selenic.com> writes:
> > 
> > > I've decided to take a stab at resurrecting Ingo's netconsole patch.
> > > 
> > > For those who missed it the first time around (for 2.4.10), this
> > > module is a "serial console over networks" which lets you catch kernel
> > > messages, oopses and so on that can't be caught by syslog.
> 
> hmm, sounds somewhat familiar, could you give
> the location of the patches/tools/etc ...
> 

I think it is included in -aa, so perhaps that is the most updated
source.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
