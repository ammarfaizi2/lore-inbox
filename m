Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSGEPkd>; Fri, 5 Jul 2002 11:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSGEPkc>; Fri, 5 Jul 2002 11:40:32 -0400
Received: from molly.vabo.cz ([160.216.153.99]:16647 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id <S317489AbSGEPk2>;
	Fri, 5 Jul 2002 11:40:28 -0400
Date: Fri, 5 Jul 2002 17:42:55 +0200 (CEST)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: moje@moje.ich.vabo.cz
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
In-Reply-To: <1025883512.17296.28.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.44L0.0207051739030.2778-100000@moje.ich.vabo.cz>
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
 <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
 <20020705142619.GN1007@suse.de>  <Pine.LNX.4.44L0.0207051643580.709-100000@moje.ich.vabo.cz>
 <1025883512.17296.28.camel@sonja.de.interearth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Jul 2002, Daniel Egger wrote:

> Am Fre, 2002-07-05 um 16.48 schrieb Tomas Konir:
> 
> > Error Log Structure 1:
> > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> >  00   08   80   ee   88   a2    e0   cc     1210341
> >  00   08   08   ee   88   a2    e0   a2     1210341
> >  00   08   87   04   1d   20    e0   cc     1210341
> >  00   00   00   04   1d   20    e0   00     1210341
> >  00   00   80   06   42   67    e1   c8     1210341
> >  00   84   00   85   42   67    e1   51     0
> > Error condition:   0    Error State:       3
>  
> > Error Log Structure 2:
> > DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
> >  00   80   00   3e   66   23    e1   c7     1386233
> >  00   80   08   3e   66   23    e0   a2     1386233
> >  00   80   30   be   66   23    e1   c7     1386233
> >  00   80   80   be   66   23    e1   c4     1386233
> >  00   08   08   26   32   a4    e0   cc     1386237
> >  00   84   00   2d   32   a4    e0   51     0
> > Error condition:   0    Error State:       3
> 
> Not good. Check for the "Reallocated Sector Ct".
>  

There are no reallocated sectors.
Do you know what these error messages means ?

	MOJE
 

-- 
Tomas Konir
Brno
ICQ 25849167


