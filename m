Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTJLAD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTJLAD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 20:03:28 -0400
Received: from moon.wincor-nixdorf.com ([193.155.23.11]:62153 "EHLO
	moon.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S261662AbTJLAD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 20:03:27 -0400
From: Ulf-Rainer Tietz <Ulf-Rainer.Tietz@Wincor-Nixdorf.com>
Reply-To: Ulf-Rainer.Tietz@Wincor-Nixdorf.com
Organization: Wincor Nixdorf
To: linux-kernel@vger.kernel.org
Subject: crash after "printk serio"
Date: Sun, 12 Oct 2003 02:08:24 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310120208.24330.Ulf-Rainer.Tietz@Wincor-Nixdorf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I try to setup a friends notebook Fujitsu Siemens C Series Lifebook.
When the kernel is booting the last I can see is serio .... and then the 
system goes off. I tried to set boot parameters like debug= ... psmouse_noext 
and I guess at least most of the possible permutations regarding ps2 and 
synaptics support in xconfig. Whatever I configure, the system crashes at the 
same spot. I tried this since 2.6.0test1 whenever I had the chance. Now I can 
do any test to help fix the bug. 
Questions: What can I do to slow down the system start, so I can handcopy the 
last messages.
How can I improve the possible output at the time of shutdown ?

Under 2.4.21 the system works. After using X11 I have to go via Hotkey to 
suspend and the´n wakeup to be able to work again , otherwise the system is 
stalled.

I can provide any .config, lspci or similar list to help solve the problem. 
Just nothing of the actual failure.
 I am not subsribed but read at least daily.

Thanks for any help
ulf

