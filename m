Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbTF2D1s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 23:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTF2D1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 23:27:48 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:7837 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S265536AbTF2D1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 23:27:47 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net is down
Date: Sun, 29 Jun 2003 05:42:32 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306290542.32473.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a friend of mine talked to a vendor of an usb 2.0/ide adapter.
They told him, that he won't get more than 12mb/sec (and even some different 
adapters we looked at were not faster), and I saw ~8mb/sec copying a large 
file to an elderly  harddisk. This harddisk does ~10mb/sec when connected to 
an ide port.  We had no faster harddisk to test, but I won't blame the ehci 
driver (which worked fine with my SiS746 board), but the adapter ;o).

Glück Auf
Volker 

