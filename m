Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269782AbUJANb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269782AbUJANb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUJANb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:31:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2194 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269782AbUJANbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:31:25 -0400
Subject: Re: patches inline in mail
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: george@mvista.com, juhl-lkml@dif.dk, clameter@sgi.com, drepper@redhat.com,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
In-Reply-To: <20040930222928.1d38389f.akpm@osdl.org>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	 <4154F349.1090408@redhat.com>
	 <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	 <41550B77.1070604@redhat.com>
	 <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	 <4159B920.3040802@redhat.com>
	 <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	 <415AF4C3.1040808@mvista.com>
	 <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
	 <415B0C9E.5060000@mvista.com>
	 <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
	 <415B4FEE.2000209@mvista.com>  <20040930222928.1d38389f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096633681.21867.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 01 Oct 2004 13:28:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-01 at 06:29, Andrew Morton wrote:
> >  Guild lines on how to insure this are welcome.
> 
> Send angry email to everyone@mozilla.org.  AFAICT it's impossible with
> recent mailnews.

The mozilla behaviour is RFC compliant[1]. Use text/plain attachments
and mark them "to view" and it should do happier things. (Except with
Linus cos Mr Dinosaur[2] doesn't believe in MIME yet)

I've not been able to coax Evolution into not chewing on non attached
text either (again RFC compliant but not useful). If anyone knows a
magic incantation for it I'd love to know.

(and it might be a good addition to the lkml faq)

Alan
[1] Yes the RFC is stupid but its the spec nowdays
[2] Thankfully not purple and singing

