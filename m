Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbRDGUrb>; Sat, 7 Apr 2001 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbRDGUrV>; Sat, 7 Apr 2001 16:47:21 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:58382 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131873AbRDGUrH> convert rfc822-to-8bit; Sat, 7 Apr 2001 16:47:07 -0400
Message-ID: <3ACF7CFD.E61F9433@t-online.de>
Date: Sat, 07 Apr 2001 22:47:57 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <Pine.LNX.4.10.10104071816560.1771-100000@linux.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> On Sat, 7 Apr 2001, Tim Waugh wrote:
> 
> > On Sat, Apr 07, 2001 at 08:42:35PM +0200, Gunther Mayer wrote:
> >
> > > Please apply this little patch instead of wasting time by
> > > finger-pointing and arguing.
> >
> > This patch would make me happy.
> >
> > It would allow support for new multi-IO cards to generally be the
> > addition of about two lines to two files (which is currently how it's
> > done), rather than having separate mutant hybrid monstrosity drivers
> > for each card (IMHO)..
> 
> It is possible to design a single function PCI device that is able to do
> everything. Your approach is just encouraging this kind of monstrosity.
> Such montrosity will look like some single-IRQ capable ISA remake, thus
> worse than 20 years old ISA.
> 
> If we want to encourage that, then we want to stay stupid for life, in my
> nervous opinion.

If you want to discourage hardware vendors, they will stay with Windows.
