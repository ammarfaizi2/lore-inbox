Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280604AbRKFVyF>; Tue, 6 Nov 2001 16:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280605AbRKFVx4>; Tue, 6 Nov 2001 16:53:56 -0500
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:4102 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S280604AbRKFVxm>; Tue, 6 Nov 2001 16:53:42 -0500
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB8405445491@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel booting on serial console ... crawling
Date: Tue, 6 Nov 2001 16:52:18 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to boot my kernel using the serial console, using the
console=ttyS0,115200 (it does the same thing with 9600) ... it work great
until :

Freeing unused kernel memory: 36k freed
serial console detected.  Disabling virtual terminals.
console=/dev/ttyS0

At this point the output of the serial line slow down dramaticly ... almost
to a halt ... I get 1 line every 30 seconds !!!

why is this slow down occuring ? the part which is 100% kernel is going fast
and ok, but when it become console related ... it slows down ?

thak you

Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.


