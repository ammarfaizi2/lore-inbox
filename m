Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUFXNny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUFXNny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUFXNny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:43:54 -0400
Received: from styx.suse.cz ([82.119.242.94]:6272 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264655AbUFXNnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:43:53 -0400
Date: Thu, 24 Jun 2004 15:45:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: cr7@os.inf.tu-dresden.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB-HID: IOWarrior added to blacklist
Message-ID: <20040624134518.GA731@ucw.cz>
References: <200405111753.23786.cr7@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405111753.23786.cr7@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:53:23PM +0200, cr7@os.inf.tu-dresden.de wrote:
> Hi all,
> 
> this is a simple patch of USB's hid-core.c to add Codemercs' IOWarrior 24 and  
> IOWarrior 40 to the blacklist as it's not a "real" HID device.
> It should be used via Codemercs' driver or via libusb.
> 
> The datasheet for IOwarrior can be found here:
> http://www.codemercs.com/Downloads/IOWarriorDatasheet.pdf

I'm sorry, I was too busy, so your patch slipped by. I applied it now,
expect in 2.6.8. Thanks for the patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
