Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264902AbSIQXFp>; Tue, 17 Sep 2002 19:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSIQXFp>; Tue, 17 Sep 2002 19:05:45 -0400
Received: from dmz.hesby.net ([81.29.32.2]:34246 "HELO firewall.hesbynett.no")
	by vger.kernel.org with SMTP id <S264902AbSIQXFp> convert rfc822-to-8bit;
	Tue, 17 Sep 2002 19:05:45 -0400
Subject: Network device -> PCI device mapping
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 01:14:15 +0200
Message-Id: <1032304455.5801.9.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

In userspace -- is there any way I can, by only knowing the interface
name (e.g. eth0), determine which PCI device it belongs to? Any bright
ideas? 

(BTW: I've tried using the SIOCGIFMAP ioctl -- which leaves me with a
base_addr and irq, but I couldn't get these matched uniquely with
/proc/bus/pci/devices) 

Thanks 
Ole André 


