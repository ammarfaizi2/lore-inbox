Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUAYXvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUAYXvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:51:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:33165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265351AbUAYXu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:50:57 -0500
Date: Sun, 25 Jan 2004 15:48:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mk.hannah@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Menuconfig Error
Message-Id: <20040125154851.15600ef8.rddunlap@osdl.org>
In-Reply-To: <40144617.7040901@verizon.net>
References: <40144617.7040901@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 22:41:27 +0000 Mark K Hannah <mk.hannah@verizon.net> wrote:

| Following error received while trying to get into "Advanced Linux Sound 
| Arch."  Crashes as soon as you select.
| 
| Also getting module compile errors...I assume it is because I can't get 
| into ALSA parameters to shut off usbaudio under ALSA.
| 
| Using Mandrake 9.2 and kernel-source-2.4.22-10mdk
| Mark Hannah
| 
| 
| Menuconfig has encountered a possible error in one of the kernel's
| configuration files and is unable to continue.  Here is the error
| report:
| 
|  Q> scripts/Menuconfig: line 832: MCmenu78: command not found
| 
| Please report this to the maintainer <mec@shout.net>.  You may also
| send a problem report to <linux-kernel@vger.kernel.org>.
| 
| Please indicate the kernel version you are trying to configure and
| which menu you were trying to enter when this error occurred.
| 
| make: *** [menuconfig] Error 1

That's caused by Mandrake's integration of ALSA in 2.4.x.
Reportedly Mandrake has fixes for it, so please check with them.

--
~Randy
