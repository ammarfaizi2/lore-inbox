Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286734AbRLaFCP>; Mon, 31 Dec 2001 00:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287446AbRLaFCF>; Mon, 31 Dec 2001 00:02:05 -0500
Received: from h24-71-223-13.cg.shawcable.net ([24.71.223.13]:24722 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S286734AbRLaFB5>; Mon, 31 Dec 2001 00:01:57 -0500
Date: Sun, 30 Dec 2001 21:01:50 -0800
From: Calyth <calyth@shaw.ca>
Subject: specifying a range of io for ide on boot
To: linux-kernel@vger.kernel.org
Message-id: <3C2FF13E.FD6F5FDD@shaw.ca>
MIME-version: 1.0
X-Mailer: Mozilla 4.74 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the problem. I got a laptop that uses an io range for ide0 that
is 0x01f0 to 0x01f8 instead of ending on 0x01f7. According the
Documentation there is no way to specify the range of the ide, only the
start of the io. Can someone help? I think I can't use the UDMA because
of this.
The laptop is a Dell Latitude XPi P133ST which uses the CMD 643 chipset.

Calyth


