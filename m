Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDONXI (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTDONXI 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:23:08 -0400
Received: from smtp.bhfc.net ([209.159.192.11]:1695 "EHLO smtp.bhfc.net")
	by vger.kernel.org with ESMTP id S261366AbTDONXH 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:23:07 -0400
From: Tim Lee <tlee5794@rushmore.com>
Reply-To: tlee5794@rushmore.com
To: "Murray J. Root" <murrayr@brain.org>, linux-kernel@vger.kernel.org
Subject: Re: Help with SiS 648 chipset and agpgart
Date: Mon, 14 Apr 2003 19:33:48 -0600
User-Agent: KMail/1.5
References: <200304140439.08812.tlee5794@rushmore.com> <20030414230105.GD1249@Master.Bellsouth.net>
In-Reply-To: <20030414230105.GD1249@Master.Bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141933.48431.tlee5794@rushmore.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 5:01 pm, Murray J. Root wrote:
> On Mon, Apr 14, 2003 at 04:39:08AM -0600, Tim Lee wrote:
> > Hi,
> >
> > I need to get agpgart to work with a SiS 648 chipset and I
> > haven't seen any implementation of such yet.  I'm currently
> > using a 2.4.19 kernel.  Without a working implementation I
> > can't use accelerated OpenGL with an ATI Radeon 9500 pro
> > because the ATI drivers require working agp support.  I've
> > tried just using the generic-sis but that causes the driver
> > to mess up big time.
> >
> > Any ideas?
>
> the SiS648 isn't in the main 2.4.x tree. It works in the -ac tree, though.

In what -ac, the most recent for the 2.4.21-pre7-ac1?

Thanks,
Tim Lee

