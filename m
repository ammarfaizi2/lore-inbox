Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUAJUSc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAJUSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:18:32 -0500
Received: from zork.zork.net ([64.81.246.102]:23690 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265420AbUAJUS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:18:27 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz>
	<20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>, kernel list
 <linux-kernel@vger.kernel.org>
Date: Sat, 10 Jan 2004 20:18:22 +0000
In-Reply-To: <20040110195531.GD22654@ucw.cz> (Vojtech Pavlik's message of
 "Sat, 10 Jan 2004 20:55:31 +0100")
Message-ID: <6u1xq77e29.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> Well, if you need to boot both 2.6 and 2.4 _and_ need to use gpm and X
> in parallel _and_ need tap-to-click in both gpm and X, then you have to
> use the kernel command line parameter and put your synaptics into legacy
> mode.

Using psmouse_proto=imps?  Or something else?

Will this also result in the passthough port not being enabled?
(I'd like to disable it.)

