Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHUH2W>; Wed, 21 Aug 2002 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHUH2W>; Wed, 21 Aug 2002 03:28:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37638
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317978AbSHUH2V>; Wed, 21 Aug 2002 03:28:21 -0400
Date: Wed, 21 Aug 2002 00:32:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <3D629163.30600@gmx.net>
Message-ID: <Pine.LNX.4.10.10208210031020.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Gunther Mayer wrote:

> Andre Hedrick wrote:
> 
> >
> >That is how I do it, since I have a code base that has been run over a
> >bus analyzer I know it works.
> >
> It would be interesting to run on a bus simulator to show the driver
> behaves correct on all allowed conditions and sensible on error conditions
> (i.e. printk and return an error to the application; don't hang the system).

Greets Gunther,

Hmmm, would you expand on the direction you are point to go?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

