Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318431AbSGSDI0>; Thu, 18 Jul 2002 23:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSGSDI0>; Thu, 18 Jul 2002 23:08:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:11783 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318431AbSGSDIZ>;
	Thu, 18 Jul 2002 23:08:25 -0400
Date: Thu, 18 Jul 2002 20:10:00 -0700
From: Greg KH <greg@kroah.com>
To: Josh Litherland <fauxpas@temp123.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad
Message-ID: <20020719031000.GA18382@kroah.com>
References: <20020719015232.GA20956@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719015232.GA20956@temp123.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 02:07:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 09:52:32PM -0400, Josh Litherland wrote:
> I want to simultaneously use a PS/2 keyboard (This is a laptop, so
> switching that out is not an option) and a USB numeric keypad, which 
> works perfectly as a usb HID keyboard.  Is there any way to do this
> with the current keyboard driver ?

Should work just fine today.  What kind of problems do you have when you
try to do it?

thanks,

greg k-h
