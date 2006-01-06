Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbWAFKEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbWAFKEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWAFKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:04:09 -0500
Received: from web26912.mail.ukl.yahoo.com ([217.146.177.79]:45171 "HELO
	web26912.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752261AbWAFKEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:04:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C3i02s8kOUW4lMRXS4FTQl/1e0yrqsdSgvPcf2dt6KaQU1iPsYoHcPLulmz6Z8SnJ5PXk0Rq4D/AygxHt3LHquVUQ8WfPcQ/C2iNfSSMvnU32sOkpbOU/iELpuxzgjvEDZ0sTuUgMXva3mT3EiiP9SntPPewPllz1hFiEGqQ0IQ=  ;
Message-ID: <20060106100402.3979.qmail@web26912.mail.ukl.yahoo.com>
Date: Fri, 6 Jan 2006 11:04:02 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: Re. 2.6.15-mm1
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <Pine.LNX.4.64.0601051631190.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote :
> The other problems _look_ like they are -mm related, not in
> plain 2.6.15. 
> Etienne, can you confirm?

  Plain linux-2.6.15 is perfectly working for me, excluding the
 small "pci=usepirqmask" warning, even when I use the Gujin
 bootloader.
  I still sometimes have strange early reboot problem when
 the kernel is not loaded and run at 1 Mbyte but at a higher
 address - but that can be considered as still "unsupported
 configuration". It may even be my fault...

  Etienne.


	
	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger. Appelez le monde entier à partir de 0,012 €/minute ! 
Téléchargez sur http://fr.messenger.yahoo.com
