Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUANGrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUANGrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:47:31 -0500
Received: from [138.44.138.254] ([138.44.138.254]:27776 "EHLO jaded.anu.edu.au")
	by vger.kernel.org with ESMTP id S263600AbUANGra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:47:30 -0500
Date: Wed, 14 Jan 2004 17:11:34 +1030
From: Patrick Cole <z@amused.net>
To: linux-kernel@vger.kernel.org
Subject: Touchpad / keyboard behaving strangely on 2.6
Message-ID: <20040114064134.GA2257@jaded>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since moving to 2.6 (same in .0 and .1), the synaptics touchpad on 
my Dell I8100 will occasionally stop moving for a few seconds, sometimes
for as much as 5 seconds, then just come back and start working again, 
while the rest of the system is fully responsive (can switch X
workspaces, launch stuff with my keybindings, etc).

Additionally, the keyboard repeat rate seems to be malfunctioning.
Almost everytime I use one of my key bindings in sawfish (Ctrl-Alt-T) to 
open a terminal window (wterm), I get a 1 or so second delay before 
the terminal actually opens, and I always get two or three open instead
of just one, even with the repeat delay set very high and using a
very swift press.  The symptom only goes away when I turn the repeat
off completely (xset r off) or I go back to my 2.4 kernel.

Anybody have any thoughts?

Patrick

-- 
Patrick Cole <z@amused.net>
