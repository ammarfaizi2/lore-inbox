Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTKFMsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 07:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTKFMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 07:48:30 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:5044 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263531AbTKFMs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 07:48:29 -0500
From: Paulo Moura Guedes <pmg@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: test9 - USB and fat32 not working
Date: Thu, 6 Nov 2003 12:48:07 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061248.07529.pmg@netcabo.pt>
X-OriginalArrivalTime: 06 Nov 2003 12:48:19.0585 (UTC) FILETIME=[414E6F10:01C3A464]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an i686 with RH9 and i installed Red Hat unofficial rpm's 
(kernel-2.6.0-0.test9.1.70.i686.rpm , etc..)

Everything is working fine expect for this boot messages (I'll try to 
remember):

USB not working - missing 
	usb_uhci
	mousedev
	keybdev

Also i can't mount my fat32 partitions. (I have no problem with RH9 kernel, 
fstab is ok)

Finally,  mouse movement is way too accelerated.

-- 
KMail - The supreme eMail client

