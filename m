Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSFKUoN>; Tue, 11 Jun 2002 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSFKUoM>; Tue, 11 Jun 2002 16:44:12 -0400
Received: from vt.fermentas.lt ([193.219.56.32]:57229 "EHLO vt.fermentas.lt")
	by vger.kernel.org with ESMTP id <S317534AbSFKUoM> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 16:44:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: vt <vt@vt.fermentas.lt>
To: linux-kernel@vger.kernel.org
Subject: no v4l devices show up in devfs
Date: Tue, 11 Jun 2002 22:43:46 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206112243.46667.vt@vt.fermentas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

regardless of kernel (2.4.pre19 or 2.5.21). maybe my devfsd.conf is wrong, but 
various tweaks did not help --- i have found nowhere on the net how exactly 
configure it for v4l devices. 

kernel just says "Linux video capture interface v.1.00", accepts pwc module 
ok, usb devices get registered, but still no video0 device.

no fb devices visible too.   
