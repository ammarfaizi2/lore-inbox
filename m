Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSJAWYI>; Tue, 1 Oct 2002 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262878AbSJAWXx>; Tue, 1 Oct 2002 18:23:53 -0400
Received: from adsl-157-199-164.dab.bellsouth.net ([66.157.199.164]:18576 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S262868AbSJAWWW>;
	Tue, 1 Oct 2002 18:22:22 -0400
Date: Tue, 1 Oct 2002 18:12:00 -0400
From: Andreas Boman <aboman@nerdfest.org>
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.40 menuconfig crashes when entering sound->alsa menu
Message-ID: <20021001221200.GA8664@midgaard.us>
Mail-Followup-To: mec@shout.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

happens with and without the alsa updates from today.

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

