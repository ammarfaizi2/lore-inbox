Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSE2N7D>; Wed, 29 May 2002 09:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSE2N7C>; Wed, 29 May 2002 09:59:02 -0400
Received: from ns.ithnet.com ([217.64.64.10]:3083 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S315282AbSE2N67>;
	Wed, 29 May 2002 09:58:59 -0400
Date: Wed, 29 May 2002 15:58:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Peter W?chtler <pwaechtler@loewe-komp.de>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9, still USB freeze
Message-Id: <20020529155849.357ee2b1.skraw@ithnet.com>
In-Reply-To: <3CF4DDE8.1020305@loewe-komp.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002 15:55:52 +0200
Peter Wächtler <pwaechtler@loewe-komp.de> wrote:

> Stephan von Krawczynski wrote:
> > Hello,
> > 
> > as noted for pre8, pre9 freezes still, when connecting a sandisk SDDR-05 to
> > USB(only device attached), and trying to mount some compact-flash. Or, as
> > an alternative test, even with no compact flash inserted, when starting up
> > xcdroast. Both completely freezes the machine.
> > 
> > pre6 was ok.
> > 
> 
> Is that on a SMP machine?

Yes, this is SMP (Asus CUV4X-D, via chipset), dual PIII.

> I think usb-storage is not completely SMP safe.
> I had occasional lockups on SMP - since I connected the readers to UP
> I had no single lockup. At work I do write a lot of compactflashes.

Interestingly everything works well with pre6, whereas pre8 and pre9 _always_
freeze.

Regards,
Stephan

