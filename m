Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWFOEwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWFOEwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 00:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFOEwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 00:52:12 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:6548 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750827AbWFOEwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 00:52:11 -0400
Message-ID: <4490E776.7080000@cmu.edu>
Date: Thu, 15 Jun 2006 00:52:06 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: cdrom support with thinkpad x6 ultrabay
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for support somewhere in the kernel for my thinkpad x6
ultrabay's cdrom drive.  Whenever I attach the ultrabay it picks up the
extra usb ports, seems to pick up the ethernet port, but it fails to
pick up anything about the dvd/cd-writer.  Nothing shows up in dmesg
about the drive at all... anyone know what I might need in the kernel?
I am using 2.6.17-rc6

Thanks!
George
