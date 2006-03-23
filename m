Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWCWR6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWCWR6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWCWR6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:58:17 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:8412 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932536AbWCWR6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:58:16 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Add quirks required to make a Shuttle PN-31 remote control work
Date: Thu, 23 Mar 2006 18:51:23 +0100
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200603202359.25558.bero@arklinux.org> <20060321071635.GC7523@suse.cz>
In-Reply-To: <20060321071635.GC7523@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231851.24029.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 21. March 2006 08:16, Vojtech Pavlik wrote:
> On Mon, Mar 20, 2006 at 11:59:24PM +0100, Bernhard Rosenkraenzer wrote:
> > Add some quirks to make a Shuttle PN-31 remote control work.
>
> Can you send me the #define DEBUG output from hid-core and hid-input?
> I'm quite curious how much broken the device is and if it weren't easier
> to implement a way how to replace the HID Report descriptor inside
> hid-core instead of adding more quirks.

Unfortunately not ATM, I don't have the hardware anymore (it was part of the 
"If you get any new hardware, give it to me for a day before selling it, to 
make sure it supports Linux" deal I have with a local computer shop).

I'll gather the debug output if/when he sells another one.
