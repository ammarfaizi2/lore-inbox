Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUDQVPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 17:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUDQVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 17:15:40 -0400
Received: from webbox180.server-home.net ([195.137.212.194]:54937 "EHLO
	webbox180.server-home.net") by vger.kernel.org with ESMTP
	id S263091AbUDQVPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 17:15:39 -0400
Message-ID: <40819E5C.7070001@clagi.de>
Date: Sat, 17 Apr 2004 23:15:08 +0200
From: Guido Classen <classeng@clagi.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.x support for prism2 USB wireless adapter?
References: <40395346.3040300@gadsdon.giointernet.co.uk> <Pine.LNX.4.44L0.0402230953141.1175-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0402230953141.1175-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that the prism2's single interface is number 1, but
> according to the USB standard interfaces are supposed to be
> numbered starting at 0.  This is a fairly common error among USB devices.
> The patch below will cause the kernel to accept the device; please let us
> know how it works out.
Is anyone working on this issue? The patch works great for me with
kernel 2.6.3 but it dosn't apply to 2.6.5. Im using a Sitecom WL12
Prims2 USB WLAN apdaper

any suggestions?

kindly regards
   Guido Classen

> [PATCH]


