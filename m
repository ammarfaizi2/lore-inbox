Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWHHOzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWHHOzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWHHOzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:55:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40718 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932596AbWHHOzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:55:12 -0400
Date: Tue, 8 Aug 2006 10:55:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christian Axelsson <smiler@lanil.mine.nu>
cc: linux-kernel@vger.kernel.org, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] USB x-pad problems
In-Reply-To: <44D6027C.4040106@lanil.mine.nu>
Message-ID: <Pine.LNX.4.44L0.0608081053250.6725-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006, Christian Axelsson wrote:

> Hello!
> 
> I'm having trouble connecting my X-box dancepad to my linux setup.
> I've attached the some logs. The intressting part is that it's working 
> fine on all windows machines Ive tested on, including a dualboot using 
> the same USB-port on the one where Ive captured these logs. Note that 
> the xpad.working.dmesg is taken from another linux system where I 
> managed to get it to work.
> 
> I've tried 2.6.17-gentoo-r4 and a vanilla 2.6.17.6 with the same results.

>From your log, it looks like the computer has trouble communicating with 
the external hub.  What happens if you plug the X-box dancepad directly 
into the computer, bypassing the hub?

Alan Stern

