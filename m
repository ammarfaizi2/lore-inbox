Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCHVBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUCHVBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:01:17 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:10003 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261206AbUCHVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:01:13 -0500
Date: Mon, 8 Mar 2004 17:59:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Johannes Resch <jr@xor.at>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Multiple oopses with 2.4.25
In-Reply-To: <404B4485.1050507@xor.at>
Message-ID: <Pine.LNX.4.44.0403081756490.1756-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Mar 2004, Johannes Resch wrote:

> Hi Marcelo,
> 
> On 2004-03-05 13:18, Marcelo Tosatti wrote:
> > On Wed, 3 Mar 2004, Johnny Strom wrote:
> >>
> >>I also get multiple oopse's with 2.4.25 plus the latest
> >>ipsec kernel patch form http://www.freeswan.org/.
> >>
> >>I have to reset the computer to get it working again,
> >>below is the oopse's:
> > 
> > 
> > Dear fellows,
> > 
> > I have seen similar reports. 
> > 
> > Can you find out which kernel does not exhibit the behaviour with the same
> > freeswan/grsec patches ?
> 
> 
> I'm not able to reproduce the oopses.
> I've been running 2.4.24 / 2.4.23 with grsec 1.9.13 without any problems 
> before.

Finding out in which 2.4.25-pre the problem starts will be helpful.

By simply reading the changelogs I can't figure what could cause such 
fuckup really. 

