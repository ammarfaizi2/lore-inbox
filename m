Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUJDM5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUJDM5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUJDM5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:57:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53911 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268131AbUJDM5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:57:43 -0400
Subject: Re: GPL Violation of Linux in Telsey Video Station Product
From: Josh Boyer <jdub@us.ibm.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alessandro Sappia <a.sappia@ngi.it>, linux-kernel@vger.kernel.org
In-Reply-To: <200410041344.45700.vda@port.imtp.ilyichevsk.odessa.ua>
References: <41613F2F.2000706@ngi.it>
	 <200410041344.45700.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1096894500.22034.15.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 04 Oct 2004 07:55:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 08:44, Denis Vlasenko wrote:
> On Monday 04 October 2004 12:16, Alessandro Sappia wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Good Morning,
> > I'm a Customer of a broadband ISP in Italy; They sell ont only the
> > connection, but they add VoIP Phone and TVoIP. (Both TV on Demand and TV
> > Broadcasting).
> > I bought a Video Station branded by my carrier and surprisingly I found
> > that the operating system the use is a modified version of linux.
> > It was possible for me to see it because the Videostation Itself is just
> > a PC with an Ethernet Card on it and it does boot from remotely.
> 
> Does it itself contain Linux? It is possible that bootstrap
> tftp loader isn't Linux. In this case Videostation itself does not
> contain Linux until you turn it on.
> 
> But downloading Linux kernel and GPLed software via
> tftp and NFS is itself an act of distribution, and I think you
> have the right to obtain source from distributor (in this case,
> your ISP).
> 

I'm all for the GPL and making sure it's followed, but could we move
such discussions some place else?  This is supposed to be a development
list.  Maybe creating a linux-gpl list (or whatever) would be better?

josh

