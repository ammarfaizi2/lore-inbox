Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUBQLIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUBQLIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:08:36 -0500
Received: from ns.schottelius.org ([213.146.113.242]:10654 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S264879AbUBQLIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:08:34 -0500
Date: Tue, 17 Feb 2004 12:08:40 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: nico-kernel@schottelius.org
Subject: usb issue in 2.6 or notebook defect?
Message-ID: <20040217110840.GR1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!

Now I am trying to recover what is possible to a usb hard disk.
I tried to dd or tar the data, but after some time it stops.
(dmesg attached).

On another host the usb hard disk can be read without any problems.
Both hosts are running Linux 2.6.2. 

Now my question is: Is it possible that not even the first harddisk is
broken, but something from the notebook? Although I remember that
reading usb disks (either adapted 2.5" notebook hard disks or usb
sticks) never went very well (even on my old Acer or the Test-Toshiba
reading and writing much data failed).

So is this a kernel USB issue or a hardware issue?
In any case, can you give me some hints howto find the source of errors?

Greetings.

Nico Schottelius
