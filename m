Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUBBWYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUBBWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:24:54 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:27457 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S265879AbUBBWYx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:24:53 -0500
Date: Mon, 2 Feb 2004 23:24:35 +0100 (CET)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: David Woodhouse <dwmw2@infradead.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <1075302289.1633.158.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58LT.0402022322540.7204@lt.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl> 
 <1074686081.16045.141.camel@imladris.demon.co.uk> 
 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet> <1075302289.1633.158.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, David Woodhouse wrote:

> On Wed, 2004-01-21 at 18:12 -0200, Marcelo Tosatti wrote:
> > Lets try the clueless approach and remove the inode reclaim highmem fixes
> > from Rik.
> > 
> > Please revert the attached patch (againts -pre6).
> 
> Did this make a difference?

I think so

oceanic:~$ uptime
 23:23:12  up 11 days,  3:32, 29 users,  load average: 0.21, 0.52, 1.10

2.4.25-pre6 +  nohighmem.patch


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
