Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUAZTaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUAZTaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:30:07 -0500
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:26640 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264488AbUAZTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:30:02 -0500
Date: Mon, 26 Jan 2004 07:29:34 -0600
From: Justin Walters <ProgramDesign@charter.net>
To: linux-kernel@vger.kernel.org
Subject: think this might be a bug
Message-Id: <20040126072934.3f689410.ProgramDesign@Charter.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8-gtk2-20031212 (GTK+ 2.2.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel 2.6.1

Probelm Pentax Optio S4 Digital Camera

here all i get in dmesg , when i turn the camera on 
ehci_hcd 0000:00:02.2: GetStatus port 6 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 6, status 501, change 1, 480 Mb/s
hub 1-0:1.0: debounce: port 6: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 6 full speed --> companion
 ehci_hcd 0000:00:02.2: GetStatus port 6 status 003001 POWER OWNER sig=se0  CONNECT

it not giving a Device nod or nothing , i dont know if its my probelm  or your guys... thanks later 
