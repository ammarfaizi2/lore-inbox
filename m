Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUAaWss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUAaWss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:48:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:59302 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265162AbUAaWsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:48:46 -0500
Date: Sat, 31 Jan 2004 20:47:32 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Andreas Metzler <lkml-2004-01@downhill.at.eu.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.25-pre4
In-Reply-To: <1075475962.18944.0.camel@midux>
Message-ID: <Pine.LNX.4.58L.0401312035080.4252@logos.cnet>
References: <1b0nY-2vi-13@gated-at.bofh.it> <1b3OA-7FV-17@gated-at.bofh.it>
  <1b4hG-8kh-21@gated-at.bofh.it>  <20040130135730.GB1215@balrog.logic.univie.ac.at>
 <1075475962.18944.0.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Jan 2004, Markus Hästbacka wrote:

> On Fri, 2004-01-30 at 15:57, Andreas Metzler wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > > On Tue, 6 Jan 2004, Mike Fedyk wrote:
> > >> On Tue, Jan 06, 2004 at 12:14:23PM -0200, Marcelo Tosatti wrote:
> > >> > It contains an ext2/3 update (mostly forward compatibility related), the
> > >>
> > >> Do you plan to merge htree?
> > >
> > > Yes, in the next -pre.
> >
> > Hm. Afaict this has not happened yet (-pre8), is it still planned for
> > .25?
> I think he meant for the 2.4.26-pre tree.

And it wont happen anymore. After saying that I would merge it, I decided
(based on input from sct and tytso) that we don't want htree in 2.4.x.

