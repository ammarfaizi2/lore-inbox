Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVLUHIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVLUHIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVLUHIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:08:30 -0500
Received: from toplitzer.net ([83.151.30.110]:27554 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S932290AbVLUHI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:08:29 -0500
From: Helmut Toplitzer <pvrusb2@toplitzer.net>
To: david-b@pacbell.net
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 21 Dec 2005 08:08:19 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512210808.20073.pvrusb2@toplitzer.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I stumbled into a quite simmilar problem as Rene Herman. 
So he asked me to mail to you. Here a short intro:

My VIA USB driver using EHCI is disconnecting my video
encoder device (Hauppauge PVRUSB2) after working for
about 10 minutes.

Details (including usb-debug output, lspci, lsusb, lsmdo) can be found at:
http://marc.theaimsgroup.com/?l=linux-usb-users&m=113508572205777&w=2

Any suggestions what to test/to do?

TIA
Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
