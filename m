Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266375AbTGJQcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbTGJQcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:32:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266375AbTGJQce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:32:34 -0400
Date: Thu, 10 Jul 2003 09:45:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mflt1@micrologica.com.hk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Message-Id: <20030710094535.1ea2270b.rddunlap@osdl.org>
In-Reply-To: <20030710080345.7907d810.rddunlap@osdl.org>
References: <200307101453.57857.mflt1@micrologica.com.hk>
	<20030710080345.7907d810.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 08:03:45 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| On Thu, 10 Jul 2003 14:53:57 +0800 Michael Frank <mflt1@micrologica.com.hk> wrote:
| 
| | Tried to config usb serial console on 2.5.74 but it's no more configurable.
| | 
| | Searched the tree and these are the only references
| | 
| | ./BitKeeper/deleted/.del-Config.help~23cda2581f02cfcb
| | ./BitKeeper/deleted/.del-Config.in~92fe774f90db89d
| | ./drivers/usb/serial/Makefile
| | ./drivers/usb/serial/usb-serial.h
| | 
| | Has this been deleted?
| 
| No, but there is a typo in the Kconfig file for it.
| Patch for it is below.  (It is from the -kj patchset. :)
| Patch by Francois Romieu <romieu@fr.zoreil.com>.

Nope.  See Greg's reply.  It's correct.

--
~Randy
