Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUBYKHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUBYKHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:07:13 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:58127 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261159AbUBYKHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:07:11 -0500
Date: Wed, 25 Feb 2004 11:07:07 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Helmut Auer <vdr@helmutauer.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HELP Re: Keyboard not working under 2.6.2
Message-ID: <20040225100707.GA3832@pclin040.win.tue.nl>
References: <403911AD.1030005@helmutauer.de> <403B101D.3070601@helmutauer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B101D.3070601@helmutauer.de>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: NIET: mailhost.tue.nl 1080; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:49:33AM +0100, Helmut Auer wrote:

> >I am using an Intel810 MoBo with an infrared module/keyboard connected to
> >an onboard PS/2 connector.
> >With a 2.4.x kernel I get the message:
> >No AT keyboard found
> >but the keyboard works fine.
> >With a 2.6.2 kernel, I don't get this message, but the keyboard does not
> >work !!!
> >Any hints what I can try ? If I connect an USB keyboard, this will 
> >work, and also if I connect a "normal" PS/2 keyboard to that PS/2 pins.
> 
> 
> Sorry for being impatient, but isn't here anyone who can give me a hint, 
> or is this the wrong place for this problem ?

Did you get precisely this message: "No AT keyboard found" ?
Who prints this message? (BIOS, bootloader, kernel? Which bootloader? Which kernel?)
