Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTIZIIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIZIIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:08:45 -0400
Received: from server0027.freedom2surf.net ([194.106.33.36]:8649 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261309AbTIZIIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:08:44 -0400
Date: Fri, 26 Sep 2003 09:08:41 +0100
From: Ian Molton <spyro@f2s.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nforce2 ethernet
Message-Id: <20030926090841.4e1e2ca3.spyro@f2s.com>
In-Reply-To: <20030926064559.GA5906@ucw.cz>
References: <20030926054449.775e2cb5.spyro@f2s.com>
	<20030926064559.GA5906@ucw.cz>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 08:45:59 +0200
Vojtech Pavlik <vojtech@suse.cz> wrote:

> 
> Well, I was suggesting it originaly, but now it's verified - it's not
> similar to the 8111e. It seems to be a nVidia design.

Heh. tell you what, though - scared me witless when the machine *wouldnt
not* boot afterwards (it didnt lock, I just rebooted and it never
posted... I had to remove power AND short the CMOS before it
recovered... most boards you only need to short the CMOS - silly
design this one ;-)

Shant be trying that again in a hurry.

The binary module seems pretty straightforward. I might see if I can use
it as an excuse to learn X86 assembler (shudder), but I have some other
projects to do first. perhaps if no-ones done it by then I'll have a go.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
