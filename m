Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUHCGxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUHCGxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHCGxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:53:35 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:58710 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265091AbUHCGx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:53:28 -0400
Subject: Re: USB troubles in rc2
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Michael Guterl <mguterl@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <944a03770408021908da573de@mail.gmail.com>
References: <200408022100.54850.ktech@wanadoo.es>
	 <20040803002634.GB26323@kroah.com>
	 <944a03770408021908da573de@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Aug 2004 00:49:58 -0600
Message-Id: <1091515798.2240.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same board.  I cannot get USB and 1394 to cohabitate.  On my
system, when I insert a USB device, the 1394 system shows itself as
handling the interrupt and the USB remains dormant.

Trever

On Mon, 2004-08-02 at 22:08 -0400, Michael Guterl wrote:
> I have an nforce2 motherboard also (Asus A7N8X Deluxe).  And I'm
> having issues as well, like the parent poster I had to previously
> revert bk-usb.patch when using mm kernels.  Now the problem persists
> in vanilla 2.6.8-rc2.  Specifically my problem is that Starting Cups
> hangs during bootup.  I removed USB support and it booted fine, but I
> can't live without USB, keyboard, mouse, and external hard drive are
> all USB.  Below is my config file hopefully it will help.

--
"You can surrender Without a prayer But never ever pray Pray without
surrender You can fight Fight without ever wining But you can never ever
win Win without fight" -- Niel Peart

