Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUAEHpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUAEHpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:45:15 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:58887 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S265890AbUAEHpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:45:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> (Linus
 Torvalds's message of "Sun, 4 Jan 2004 18:52:56 -0800 (PST)")
References: <20040103040013.A3100@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
	<20040103141029.B3393@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
	<20040104000840.A3625@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
	<20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
Date: Mon, 05 Jan 2004 02:44:10 -0500
Message-ID: <m31xqedelx.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> Why? Becuase that _program_ sure as hell isn't
Linus> running across a reboot.

Is that strictly true?  With (software) suspend to disk,
will the old device enumeration data be recovered from
the suspend partition?

-JimC

