Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTBXTPJ>; Mon, 24 Feb 2003 14:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBXTPJ>; Mon, 24 Feb 2003 14:15:09 -0500
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:33721 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S266810AbTBXTPI>; Mon, 24 Feb 2003 14:15:08 -0500
Date: Mon, 24 Feb 2003 20:25:20 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: James Bourne <jbourne@mtroyal.ab.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tg3 patches needed for 2.4.19/2.4.20
Message-ID: <20030224202520.C8760@pc9391.uni-regensburg.de>
References: <20030224131434.I24600@pc9391.uni-regensburg.de> <Pine.LNX.4.51.0302240729200.21620@skuld.mtroyal.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.51.0302240729200.21620@skuld.mtroyal.ab.ca>; from jbourne@mtroyal.ab.ca on Mon, Feb 24, 2003 at 15:37:54 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.2003   15:37 James Bourne wrote:
> On Mon, 24 Feb 2003, Christian Guggenberger wrote:
> 
> > Hi,
> >
> > In former days there always had been some problems with broadcom GBit Nics.
> So
> > I'd like to ask what patches for the tg3 are recommended for production use
> 
> > with 2.4.19/2.4.20.
> 
> Hi,
> I have created a patch for 2.4.20 for the tg3 driver from Jeff
> Garziks and David Millers tg3 1.4c driver which I'm hoping will be
> in the next kernel.
> 
> The patch is at http://www.hardrock.org/kernel/2.4.20/
> 
> Note that because of NAPI the 2.4.20 driver will not work with 2.4.19...
> 
Hallo,

thanks, I'll try 'em out. 
cheers.
Christian

P.S. 2.4.19 is not so important, as the other machine (needs xfs, and I'll 
stay with 2.4.19) has no onboard tg3, but gets a e1000 instead.

