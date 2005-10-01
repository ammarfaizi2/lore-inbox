Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVJAVaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVJAVaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJAVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:30:24 -0400
Received: from bay105-f35.bay105.hotmail.com ([65.54.224.45]:62593 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750859AbVJAVaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:30:23 -0400
Message-ID: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
X-Originating-IP: [62.79.29.130]
X-Originating-Email: [lokumsspand@hotmail.com]
From: "lokum spand" <lokumsspand@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: A possible idea for Linux: Save running programs to disk
Date: Sat, 01 Oct 2005 13:30:22 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Oct 2005 21:30:23.0122 (UTC) FILETIME=[54AF1F20:01C5C6CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I allow myself to suggest the following, although not sure if I post in
the right group:

Suppose Linux could save the total state of a program to disk, for
instance, imagine a program like mozilla with many open windows. I give
it a SIGNAL-SAVETODISK and the process memory image is dropped to a
file. I can then turn off the computer and later continue using the
program where I left it, by loading it back into memory.

Would that be possible? At least a program can be given a ctrl-z and is
swapped out if physical memory is needed. This is somewhat similar (?)
Would that need kernel parameters to be included in the process image
file? What about X-windows resources? Is this simply to easy to exploit
by having altered process images loaded back into the memory? ('virus')

If possible, a neat titlebar icon 'zzz' could be added to the decoration
provided by the (X) window manager.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

