Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVI1Lma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVI1Lma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVI1Lm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:42:29 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:39311 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750858AbVI1Lm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:42:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HLNXlkcWS7OHx3cCGdNKBAySrLBb4AqFtiO9FKT0ZSSURT9oJuqnmzWe671b4zkLlIGl2/lPBJGameFQFWKOxUOG89WTUNqhrR0JlfwtIw/mcQfgTuy9Fg96s9Vtr0s/Jkucm0Ky6qhH5xABHMLD4p4JXmOsWay5RoEOkZZIeFU=  ;
Message-ID: <20050928114228.13609.qmail@web31802.mail.mud.yahoo.com>
Date: Wed, 28 Sep 2005 04:42:28 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into  the kernel
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <91888D455306F94EBD4D168954A9457C0438823C@nacos172.co.lsil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Moore, Eric Dean" <Eric.Moore@lsil.com> wrote:

> On Tuesday, September 27, 2005 4:51 PM, Luben Tuikov wrote:
> 
> > Christoph's code is
> >  * MPT based only,
> >  * doesn't follow a spec to save its life,
> >  * far inferior in SAS capabilities and SAS representation
> >    again, due to the fact that it is MPT based.
> > 
> > Since the whole point of MPT is to _hide_ the transport.
> > 
> 
> 
> Hi Luben,
> 
> OK, Man are you alright?
> 
> I've heard of other vendors planning to 
> provide solutions where sas is implemented
> in firmware, similar to MPT.  Christophs
> sas layer is going to work with other 
> solutions, don't think of it being 
> MPT centric.

Where in what I said above do I say that it will _not_
work with _other_ MPT based drivers?  Nowhere!

Yes it _will_ work with other MPT-like drivers but
to cut and paste again from above:
 * MPT based only,
 * doesn't follow a spec to save its life,
 * far inferior in SAS capabilities and SAS representation
   again, due to the fact that it is MPT based.

When I say MPT, I do not mean MPT(R), I mean MPT as
in technology, not as in trademark.

     Luben


