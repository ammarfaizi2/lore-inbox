Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSE1LaA>; Tue, 28 May 2002 07:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSE1L37>; Tue, 28 May 2002 07:29:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24843 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313773AbSE1L37>; Tue, 28 May 2002 07:29:59 -0400
Message-Id: <200205281124.g4SBOWY22443@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Matt Bernstein <matt@theBachChoir.org.uk>
Subject: Re: VM oops in RH7.3 2.4.18-3
Date: Tue, 28 May 2002 14:26:24 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205280026160.13855-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 May 2002 21:28, Matt Bernstein wrote:
> On May 27 Benjamin LaHaise wrote:
> >On Mon, May 27, 2002 at 10:33:12AM -0400, Jes Sorensen wrote:
> >> >>>>> "Matt" == Matt Bernstein <matt@theBachChoir.org.uk> writes:
> >>
> >> Matt> This is a dual Athlon, 1 gig registered ECC DDR RAM, will try
> >> Matt> 2.4.18-4 but it doesn't look ext3-related (the only big local
> >> Matt> filesystem is reiserfs over s/w raid0).
> >>
> >> Please send this to Red Hat before the kernel list. They are
> >> responsible for maintaining their kernel.
> >
> >I'm sure Rik is interested in any feedback on the rmap patches that
> >occur out in the wild...  even if they happen in vendor kernels.  With
> >that said, we appreciate getting bugs like this filed in bugzilla.
>
> Thanks--I'll see what I can do, though I really don't have much more to go
> on than the oops. I think power supply / cooling are not to blame.. :-/

You may slightly underclock your system. This will lower wattage and heat
production.

Wait a day or two for the oops. If it's gone, you have a hw problem.
--
vda
