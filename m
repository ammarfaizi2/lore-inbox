Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbREQO2w>; Thu, 17 May 2001 10:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbREQO2l>; Thu, 17 May 2001 10:28:41 -0400
Received: from moe.unleashed.org ([216.86.199.34]:31751 "HELO
	mail.unleashed.org") by vger.kernel.org with SMTP
	id <S261854AbREQO2Y>; Thu, 17 May 2001 10:28:24 -0400
Date: Thu, 17 May 2001 07:28:23 -0700
From: Leah Cunningham <leah@unleashed.org>
To: ps <ps@rzeczpospolita.pl>
Cc: Pim Zandbergen <P.Zandbergen@macroscoop.nl>, linux-kernel@vger.kernel.org
Subject: Re: RH 7.1 on IBM xSeries 240
Message-ID: <20010517072823.A43159@unleashed.org>
In-Reply-To: <fa.fhhq4kv.gguq9t@ifi.uio.no> <fa.fuo78ov.ikad9g@ifi.uio.no> <t977gtcpq17r85vlggngi9mk3a1k6qt01u@4ax.com> <3B03A835.3DD48BDC@rzeczpospolita.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B03A835.3DD48BDC@rzeczpospolita.pl>; from ps@rzeczpospolita.pl on Thu, May 17, 2001 at 12:30:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- > > >Yes, I have the newest BIOS and SR Firmware.
- > > >I have 2 x 1GHz CPUs and IBM PCI ServeRAID 4.71.00  <ServeRAID 4L>
- > 
- > Firmware is 4.70.17, I'v got it directly from IBM engineer.
- > Previous firmware (2 days ago) was really 4.50 but it performed worse
- > (was less stable in performance).

That makes a bit more sense.  This code is stil in test, however.
Previously you said 4.71.00.

- > > There is, however a driver version 4.72 in the latest 2.4.4-ac
- > > kernels.
- > 
- > I've tried it but it was all the same - I came back to 4.71

It still seems like a BIOS issue.  Does is work on a default RH
installation, with the RH included kernel?

             I can't believe it's not UNIX!!!
------------------------------------------------------------
Leah Cunningham             |  SuSE Expert, NOS Engineer, 
Undisclosed Address         |  QA & Linux geek, et al.        
