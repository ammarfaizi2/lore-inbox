Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbUK0AyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUK0AyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbUK0Axv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:53:51 -0500
Received: from cpmx2.mail.saic.com ([139.121.17.172]:47607 "EHLO
	cpmx2.mail.saic.com") by vger.kernel.org with ESMTP id S263089AbUK0Axd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:53:33 -0500
Subject: usb-storage/HAL oddity in 2.6.10-rc?
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 26 Nov 2004 11:38:30 +0000
Message-Id: <1101469110.6185.9.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I started using 2.6.10-rc kernels, my usb flashdrive only seems to
be partially detected by HAL. It shows up fine in dmesg, the device is
detected and the partitions recognised, however in the HAL device
manager it shows as a SCSI host interface, without the volume being
detected underneath it. This all works fine on 2.6.9 running the same
kernel options.

Anybody got any ideas, before I go compiling kernels to find out where
it changed?

Cheers,
Eamonn
-- 
Eamonn Hamilton

Senior Systems Engineer
SAIC Ltd
Tel : 01224 333833

