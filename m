Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264417AbSIQSCC>; Tue, 17 Sep 2002 14:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264436AbSIQSCC>; Tue, 17 Sep 2002 14:02:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264417AbSIQSCB>; Tue, 17 Sep 2002 14:02:01 -0400
Date: Tue, 17 Sep 2002 14:06:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Greg KH <greg@kroah.com>
cc: Thomas Dodd <ted@cypress.com>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net, gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
In-Reply-To: <20020917174631.GD2569@kroah.com>
Message-ID: <Pine.LNX.3.95.1020917135645.147A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Greg KH wrote:

> On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> > 
> > I get the feeling it's not a true mass storage device.
> 
> Sounds like it.
> 
> > The windows drivers talk about TWAIN. And the vendor ID
> > is for ViewQuest Technologies, which has a similar camera,
> > also with TWAIN drivers. I can send you the drivers from both
> > if you think they would help.

TWAIN is an old attempt at an Apple standard, started in 1992.
It is a protocol for Scanners, Audio, and Camera controls, etc.
The last 'event' recorded by www.twain.org was in May of 2001,
supporting Mac OS X. It is an API, i.e., applicatons programming
Interface, not a protocol on the wire or related to hardware.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

