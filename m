Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318453AbSGSDXP>; Thu, 18 Jul 2002 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318454AbSGSDXP>; Thu, 18 Jul 2002 23:23:15 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14343 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318453AbSGSDXO>;
	Thu, 18 Jul 2002 23:23:14 -0400
Date: Thu, 18 Jul 2002 20:24:45 -0700
From: Greg KH <greg@kroah.com>
To: Josh Litherland <fauxpas@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad
Message-ID: <20020719032445.GA18456@kroah.com>
References: <20020719015232.GA20956@temp123.org> <20020719031000.GA18382@kroah.com> <20020719032008.GA22934@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719032008.GA22934@temp123.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 02:16:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:20:08PM -0400, Josh Litherland wrote:
> On Thu, Jul 18, 2002 at 08:10:00PM -0700, Greg KH wrote:
> 
> > Should work just fine today.  What kind of problems do you have when you
> > try to do it?
> 
> Just not getting any events from the keypad.  When I load up evdev, and
> cat the device I get the appropriate gibberish, so the device is
> detected okay.  This is 2.4.18, if that makes a difference for the
> purposes of this discussion.

If the device is detected, how is it detected?  Is the USB HID driver
binding to the device?

thanks,

greg k-h
