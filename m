Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266134AbUFIOSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUFIOSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIOSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:18:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:17280 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266134AbUFIOSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:18:08 -0400
Date: Wed, 9 Jun 2004 16:16:07 +0200
From: Karsten Keil <kkeil@suse.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] weird code in some isdn drivers
Message-ID: <20040609141607.GA968@pingi3.kke.suse.de>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
	linux-kernel@vger.kernel.org
References: <20040609123633.GH21168@wohnheim.fh-wedel.de> <20040609131628.GA10403@pingi3.kke.suse.de> <20040609133003.GO21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609133003.GO21168@wohnheim.fh-wedel.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.4-52-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 03:30:03PM +0200, Jörn Engel wrote:
> On Wed, 9 June 2004 15:16:28 +0200, Karsten Keil wrote:
> > On Wed, Jun 09, 2004 at 02:36:33PM +0200, Jörn Engel wrote:
> > > Karsten, Kai,
> > > 
> > > while I agree that this is a measurement bug, it's not exacly fun to
> > > look at the code in question.  Can you please find a solution for
> > > hscx_irq.c?
> > 
> > HiSax and I4L is in bugfix only mode, since it will replaced
> > by other drivers. So I do not want waste time for soon obsolate code.
> 
> Valid solution.  Any date as to when the new drivers will be
> available?
> 

I hope that I have enough time to fix the known issues in mISDN this month
and implement some more hardware, after this it should go into mainline.

-- 
Karsten Keil
SuSE Labs
ISDN development
