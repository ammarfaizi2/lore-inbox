Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSHEFbi>; Mon, 5 Aug 2002 01:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSHEFbi>; Mon, 5 Aug 2002 01:31:38 -0400
Received: from midiowa2.midiowa.net ([64.71.65.202]:53924 "EHLO midiowa.net")
	by vger.kernel.org with ESMTP id <S318299AbSHEFbh>;
	Mon, 5 Aug 2002 01:31:37 -0400
Date: Mon, 5 Aug 2002 00:34:27 -0500
From: Tyler Longren <tyler@captainjack.com>
To: kiza@gmx.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Message-Id: <20020805003427.7e7fc9f4.tyler@captainjack.com>
Organization: Captain Jack Communicatins
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to let you know, this problem isn't just happening to you.

I compiled 2.4.19 using the same config file I used for 2.4.18 (yes, I
also turned on CONFIG_USB_HIDINPUT).  Needless to say, the mouse didn't
work on reboot.  I saw your post and compiled everything into the
kernel, and everything worked great on reboot.  So, I think this is
probably a real 2.4.19 problem.  Not something specific to you.

Tyler Longren
