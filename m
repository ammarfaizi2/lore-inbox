Return-Path: <linux-kernel-owner+w=401wt.eu-S965190AbWLOVy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWLOVy4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWLOVy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:54:56 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39732 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965189AbWLOVyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:54:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Date: Fri, 15 Dec 2006 22:56:59 +0100
User-Agent: KMail/1.9.1
Cc: Neil Brown <neilb@suse.de>, Jurriaan <thunder7@xs4all.nl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
References: <20061204203410.6152efec.akpm@osdl.org> <200612152215.23629.rjw@sisk.pl> <4583187A.4020602@garzik.org>
In-Reply-To: <4583187A.4020602@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612152256.59824.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 15 December 2006 22:49, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > The other box is mine and it works just fine with 2.6.20-rc1.
> > 
> >> I think something bad happened in sata land just recently.
> > 
> > Yup.  Please see, for example:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116621656432500&w=2
> > 
> > It looks like the breakage is in sata, in the patches that went in after
> > 2.6.19-rc6-mm2 (that one worked for me like charm).
> 
> 
> So.... 2.6.20-rc1 works for you?

Yes.

Greetings,
Rafael
