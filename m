Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVEPQTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVEPQTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVEPQTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:19:20 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:11187 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261731AbVEPQTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:19:16 -0400
Subject: Re: ioctl to keyboard device file
From: Marcel Holtmann <marcel@holtmann.org>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0505162112240.25368@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
	 <1115831651.23458.74.camel@pegasus>
	 <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
	 <1115834000.23458.77.camel@pegasus>
	 <Pine.LNX.4.60.0505121454240.26644@lantana.cs.iitm.ernet.in>
	 <1115892091.18499.17.camel@pegasus>
	 <Pine.LNX.4.60.0505161418470.31612@lantana.cs.iitm.ernet.in>
	 <1116237241.10063.3.camel@pegasus>
	 <Pine.LNX.4.60.0505162112240.25368@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Mon, 16 May 2005 18:19:32 +0200
Message-Id: <1116260372.10063.18.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

why do you always remove the CC to the mailing list or is too hard to
press the Reply to All button?

>     Thank u very much for guiding me in right direction. Sorry to disturb 
> u.  Can u suggest me some refence material for knowing how to write
> user space keyboard driver using uinput.c ,
> I have seen the code of uinput.c,  keybdev.c ,but not getting an idea
> to write keyboard driver from it.

Use Google to find example code on how to use uinput. There must also
still exists some old Bluetooth HID code that used uinput.

> Does this solution work with X-windows also?

I already answered this one. This is native input subsystem stuff and
has nothing to do with the higher applications.

Regards

Marcel


