Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCaOYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCaOYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCaOYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:24:22 -0500
Received: from simmts6.bellnexxia.net ([206.47.199.164]:28598 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261462AbVCaOYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:24:08 -0500
Message-ID: <4016.10.10.10.24.1112278858.squirrel@linux1.attic.local>
In-Reply-To: <Pine.LNX.4.61.0503310706280.8616@chaos.analogic.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>   
    <1112011441.27381.31.camel@localhost.localdomain>   
    <1112016850.6003.13.camel@laptopd505.fenrus.org>   
    <1112018265.27381.63.camel@localhost.localdomain>   
    <20050328154338.753f27e3.pj@engr.sgi.com>   
    <1112055671.3691.8.camel@localhost.localdomain>   
    <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com>   
    <1112059642.3691.15.camel@localhost.localdomain>   
    <Pine.LNX.4.61.0503290659360.10929@chaos.analogic.com>   
    <Pine.LNX.4.61.0503301446430.30163@chimarrao.boston.redhat.com>   
    <Pine.LNX.4.61.0503301455570.28630@chaos.analogic.com>
    <3343.10.10.10.24.1112268948.squirrel@linux1.attic.local>
    <Pine.LNX.4.61.0503310706280.8616@chaos.analogic.com>
Date: Thu, 31 Mar 2005 09:20:58 -0500 (EST)
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: "Sean" <seanlkml@sympatico.ca>
To: linux-os@analogic.com
Cc: "Rik van Riel" <riel@redhat.com>, "Steven Rostedt" <rostedt@goodmis.org>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, floam@sh.nu,
       "LKML" <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       "Paul Jackson" <pj@engr.sgi.com>, gilbertd@treblig.org,
       vonbrand@inf.utfsm.cl, bunk@stusta.de
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, March 31, 2005 7:34 am, linux-os said:
>
> Sure it does. Before the GPL-only stuff the only problem one would
> have with a proprietary module, i.e., one that didn't contain
> the GPL "license" notice, was that the kernel would be marked
> "tainted". Everything would still work.
>
> With the ADDITIONAL RESTRICTION added, the module won't even work
> because an ARTIFICIAL CONSTRAINT was added to prevent its use
> unless a GPL "license" notice existed.
>

There are absolutely no additional restrictions for anyone that is in full
compliance with the spirit and intent of the GPL.  Full Stop.

Runtime restrictions do not fall under the GPL anyway, otherwise it would
be illegal to impose _any_ security restrictions on a GPL system.

You are just DeadWrong(Tm) on this issue.

Sean


