Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUJZVen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUJZVen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUJZVcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:32:55 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:31702 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261486AbUJZVbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:31:14 -0400
Message-ID: <417EC21F.3060401@imag.fr>
Date: Tue, 26 Oct 2004 23:31:11 +0200
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EHCI problem on EPIA MII 12000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I have an EPIA MII 12000 and an Epson Stylus Photo R300 printer.
if I have the EHCI driver compiled in, it seems I can't get the rpinter 
to be recognized, with the following errors :

kernel version is 2.6.9-gentoo-r1

Oct 26 20:07:18 [kernel] usb 1-1: new high speed USB device using address 7
Oct 26 20:07:23 [kernel] usb 1-1: control timeout on ep0out
                 - Last output repeated twice -
Oct 26 20:07:29 [kernel] usb 1-1: device not accepting address 7, error -110
Oct 26 20:07:29 [kernel] usb 1-1: new high speed USB device using address 8
Oct 26 20:07:34 [kernel] usb 1-1: control timeout on ep0out
                 - Last output repeated twice -
Oct 26 20:07:39 [kernel] usb 1-1: device not accepting address 8, error -110

