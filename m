Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbSLRWGj>; Wed, 18 Dec 2002 17:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLRWGj>; Wed, 18 Dec 2002 17:06:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55313
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267362AbSLRWGU>; Wed, 18 Dec 2002 17:06:20 -0500
Date: Wed, 18 Dec 2002 13:58:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "D.A.M. Revok" <marvin@synapse.net>, Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 
 Promise ctrlr, or...
In-Reply-To: <1040251122.26501.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10212181358290.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 2002, Alan Cox wrote:

> On Wed, 2002-12-18 at 21:35, D.A.M. Revok wrote:
> > So.  I /think/ that somehow the Promise controller isn't being 
> > initialized properly by the Linux kernel, UNLESS the mobo's BIOS inits 
> > it first?
> 
> In some situations yes. The BIOS does stuff including fixups we mere
> mortals arent permitted to know about.
> 

That is because I am not permitted to invoke that majic wand yet.

Andre Hedrick
LAD Storage Consulting Group

