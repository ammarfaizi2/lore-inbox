Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVKGQR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVKGQR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKGQR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:17:27 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:19902 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S964859AbVKGQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:17:27 -0500
Date: Mon, 7 Nov 2005 11:17:20 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3D video card recommendations
In-Reply-To: <1131373462.11265.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511071115360.2132@innerfire.net>
References: <1131112605.14381.34.camel@localhost.localdomain> 
 <1131349343.2858.11.camel@laptopd505.fenrus.org> 
 <1131367371.14381.91.camel@localhost.localdomain>
 <1131373462.11265.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Alan Cox wrote:

> On Llu, 2005-11-07 at 07:42 -0500, Steven Rostedt wrote:
> > Are there good 3D cards that don't depend on a proprietary module, that
> > can run on a AMD64 board?  That was pretty much my questing to begin
> > with :)
> 
> Some of the radeons - R3xx is pretty close to usable R2xx works well.
> Support for running 32bit hardware accelerated apps on 64bit kernel
> recently went in.
> 

I would also suggest avoiding PCI-E cards for the time being as 
there is no DRI support for them. (although if I'm not mistaken that will 
improve in 2.6.15).

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
