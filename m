Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318967AbSHWRTM>; Fri, 23 Aug 2002 13:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318975AbSHWRTM>; Fri, 23 Aug 2002 13:19:12 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23561
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318967AbSHWRTL>; Fri, 23 Aug 2002 13:19:11 -0400
Date: Fri, 23 Aug 2002 10:08:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@mandrakesoft.com,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <20020823121059.D20963@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208231002220.14761-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Russell King wrote:

> On Fri, Aug 23, 2002 at 12:45:03AM -0700, Andre Hedrick wrote:
> > This is where JG's hard work and my time with him explaining it will help
> > most.  Also case where RMK's ARM toys do fun things and the assumption by
> > the driver that POST is valid is DEAD WRONG.  I will repeat the assumption
> > of my code about POST is DEAD WRONG!  POST like events happen at different
> > times for various archs.
> 
> Yet more FUD.  Andre - go away and come back once you've calmed down.
> 
> Maybe its because you don't actually understand my IDE hardware.  I
> dunno.  But you are "DEAD WRONG" about the crap you've written above.
> 
> Completely.

NO, I just misreferenced you because you was asked to help in a situation
with G Britton, as you have refreshed my memory with a hammer.

So I apologize for mixing events and people.

The point still stands, there are case where the OS is launched,
regardless of bootloading, where devices can be lost if the time limits
are not followed.  In the case where my memory failed, you reminded me the
device took 40 secs to spinup.

Not dead wrong just dead tired again.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

