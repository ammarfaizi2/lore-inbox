Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVJIWbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVJIWbw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVJIWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:31:52 -0400
Received: from deliverator7.gatech.edu ([130.207.165.169]:64674 "EHLO
	deliverator7.gatech.edu") by vger.kernel.org with ESMTP
	id S1750968AbVJIWbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:31:51 -0400
Message-ID: <43499A44.2070803@mail.gatech.edu>
Date: Sun, 09 Oct 2005 18:31:32 -0400
From: Luke Albers <gtg940r@mail.gatech.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: USB-> bluetooth adapter problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 3com USB bluetooth adapter, that worked for  me at one time, 
that I can't get working anymore.

The model is 3CREB96B

Sometimes it isnt even noticed when I plug it in, but after restarting 
hotplug I get this:

usb 4-1: new full speed USB device using uhci_hcd and address 2
hci_usb_probe: Can't set isoc interface settings
usb 4-1: USB disconnect, address 2

I don't think that I have removed any options from the kernel that 
should cause this, and other USB devices work fine.

Can someone please explain this message in more detail (google turns up 
very little)?

Thanks
