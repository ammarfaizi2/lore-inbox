Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSKZEye>; Mon, 25 Nov 2002 23:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSKZEye>; Mon, 25 Nov 2002 23:54:34 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:49394 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266144AbSKZEye>; Mon, 25 Nov 2002 23:54:34 -0500
Date: Tue, 26 Nov 2002 00:01:22 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.49-ac1 - mouse and keyboard issues
Message-ID: <20021126050122.GA1640@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200211252352.gAPNqnt09081@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211252352.gAPNqnt09081@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 06:52:49PM -0500, Alan Cox wrote:
> 
> Linux 2.5.49-ac1
> -	Merge with Linus 2.5.49

P4S533 (SiS645DX chipset)
P4 2GHz
1G PC2700 RAM
ps2 keyboard & mouse
Logitech Marble+ will use either ImPS/2 or Mouseman+ protocol in X

Using devfs.

This still doesn't see the mouse, although /dev/psaux exists as a
link to /dev/misc/psaux and gpm starts & stops [OK]

In X the keyboard is also dead.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

