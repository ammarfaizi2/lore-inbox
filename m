Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424201AbWLBRBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424201AbWLBRBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424209AbWLBRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:00:59 -0500
Received: from quechua.inka.de ([193.197.184.2]:55249 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1424201AbWLBRA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:00:59 -0500
Message-ID: <4571AFED.8060200@dungeon.inka.de>
Date: Sat, 02 Dec 2006 17:55:09 +0100
From: Andreas Jellinghaus <aj@dungeon.inka.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.19 still crashing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Ciphire-Security: plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my msi s270 laptop. but all vanilla kernel I ever tried do
that, also the debian and ubuntu kernel are instable too.
But: xen 3.0.2 plus xen'ified linux 2.6.16.31 are rock solid.
any idea what the issue could be? I'm running 64bit kernel,
64bit userland (plus some 32bit apps), and the cpu is a turion
mt-40 (sempron users seem to not have this problem).

I documented all details, config files, dmesg, /proc/interrupts,
lspci -vvv and xorg log file at
	http://www.megawiki.org/wiki/S270Crashing

I can also mail you all those files (didn't want to spam
linux-kernel with a huge mail), and provide any other information
that can help, try patches or command line options, or different
compile options or whatever you can suggest.

Thanks for your help!

Regards, Andreas
