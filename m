Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSLMEVl>; Thu, 12 Dec 2002 23:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSLMEVl>; Thu, 12 Dec 2002 23:21:41 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:35511 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261310AbSLMEVk>; Thu, 12 Dec 2002 23:21:40 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15865.25347.685921.293741@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 13 Dec 2002 13:33:07 +0900
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5 Changes doc update.
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lkml Dave Jones writes:

 ...
> Input layer.
> ~~~~~~~~~~~~
 ...
> - Users of multimedia keys without X will see changes in how the kernel 
>   handles those keys. People who customize keymaps or keycodes in 2.4 
>   may need to make some changes in 2.5

Could you elaborate on this, or put in a pointer describing the
differences?  I use a jp106 keyboard and the Yen/Backslash - Bar key
(keycode 133, keysyms 0x5c and 0x7c) has disappeared.  It's most
inconvenient not being able to type a pipeline on the console.

