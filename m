Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTGWMbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270240AbTGWMbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:31:32 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:42501 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S270237AbTGWMbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:31:31 -0400
Date: Wed, 23 Jul 2003 14:32:41 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>, Andre Hedrick <andre@linux-ide.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, <andersen@codepoet.org>,
       <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
In-Reply-To: <1058960631.5520.22.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307231425130.12651-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-23 at 11:51, Adrian Bunk wrote:
> > > v2 or later. The GPL only permits "any version" or "n or later".
> 
> > This implicitely says that if the version of the GPL is specified it's 
> > fixed.
> 
> It says you may use "this or any later version" or you may not specify.
> It doesn't permit you to specify "this version alone". See the no
> additional restrictions clause

Sorry, IANAL of course, but IMHO this can't be true:

If the copyright holder puts a note on his code saying it is released 
under version 2 of the GPL then clearly neither the "or any later" nor the 
"not specified" cases apply. And I really fail to see how one could 
argue this were an additional restriction compared to GPL v2 literally!

Btw, you aren't saying linux-kernel would *not* come with a valid GPL, 
according to linux/COPYING, are you?

Martin

