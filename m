Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTGFVDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTGFVDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:03:09 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:39185 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S263628AbTGFVCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:02:11 -0400
Date: Sun, 6 Jul 2003 22:11:43 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: S?rgio Duarte e Silva <sduartes@mandic.com.br>
Cc: linux-kernel@vger.kernel.org, linux-8086@vger.kernel.org
Subject: Re: ELKS - 80188 Newbie
Message-ID: <20030706211143.GI7556@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	S?rgio Duarte e Silva <sduartes@mandic.com.br>,
	linux-kernel@vger.kernel.org, linux-8086@vger.kernel.org
References: <3831.200.154.192.236.1057452982.squirrel@www.mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3831.200.154.192.236.1057452982.squirrel@www.mandic.com.br>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 09:56:22PM -0300, S?rgio Duarte e Silva wrote:

> I would like to run Linux on an embedded 80188 Tern board
> (www.tern.com). Is there

ELKS (http://elks.sourceforge.net) has it's own mailing list:
linux-8086@vger.kernel.org you can subscribe using majordomo. This
would be the best place to discuss this.

It's not a Linux port rather a subset and implementation for 8086.
Currently it is mostly set up to run off PC architecture, depending on
the board it may run out of the box, or may require some porting. If the
board supports floppy or an IDE hdd you probably can quickly check if
you can get a bootable system

> anyone here that already made this? Is there any easy tutorial or boot
> code already made for this processor?

ELKS is bootable - and there is a user space, without a closer look I
couldn't say if it would work out of the box on this board.  There are
stock boot images, as well as EDE which is designed to install ELKS onto
the HDD.  Some of the ELKS developers are working on other install
scripts.

I suggest you subscribe to linux-8086 and we'll see what we can do to
help you.  Some more details about the board might help us. There is
also a #elks channel on irc.freenode.net.

Paul
