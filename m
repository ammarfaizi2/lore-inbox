Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFZMVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFZMVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFZMVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:21:53 -0400
Received: from god.demon.nl ([83.160.164.11]:57106 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261187AbVFZMVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:21:51 -0400
Date: Sun, 26 Jun 2005 14:21:49 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 USB Keypad still not working
Message-ID: <20050626122149.GA18869@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> PhoneSkype USB Phone SK-04.
> It gets detected, is registered in /sys/bus/usb as a Keypad.
> Everything 
> else USB works including the phone handset. Nothing is detected by 
> showkey when keys are pressed.
> # less /sys/bus/usb/devices/usb3/3-2/3-2:1.3/interface
> Keypad

Hi Sid,
	
	Search results for 'sk04'
	 
	Documents 1 - 7 of 7 matches. More *'s indicate a better match.
	**** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
	**** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
	*** LKML: Sid Boyce: Re: 2.6.12 USB Keypad still not working
	*** LKML: Andrew Morton: Re: 2.6.12 USB Keypad still not working
	*** LKML: Sid Boyce: 2.6.12 USB Keypad still not working
	** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
	** LKML: Sid Boyce: RE: [PATCH] new driver for yealink usb-p1k phone
	 

Well the yealink driver is specifically targeted for the USB-P1K from
Yealink, I would be suprised if it works with the SK04.

Apart from that, the SK-04 manual seems to indicate that its a generic
HID keyboard with a generic USB sound card.

I dont have a generic HID usb keyboard myself so I cant give you first hand
infos.

In any case its best to consult the linux-usb-* mailing lists. 

Henk

