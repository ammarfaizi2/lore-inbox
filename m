Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbRGCO6K>; Tue, 3 Jul 2001 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRGCO54>; Tue, 3 Jul 2001 10:57:56 -0400
Received: from slentms1.vantcom.net ([200.225.160.21]:40198 "EHLO
	slentms1.vantcom.net") by vger.kernel.org with ESMTP
	id <S264745AbRGCO5j>; Tue, 3 Jul 2001 10:57:39 -0400
Message-ID: <734932D6EA60D511A13600508BDE724864BE@slentms1.vantcom.net>
From: Alessandro Motter Ren <Alessandro.Ren@vantcom.net>
To: linux-kernel@vger.kernel.org
Subject: Scsi errors on boot.
Date: Tue, 3 Jul 2001 11:57:26 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I am getting the follwing error messages on the kernel boot. Does
anyone have any idea what the problem might be? The kernel is 2.2.19.
	Thanks.

Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:1) Synchronous at 160.0 Mbyte/sec, offset 63.
(scsi0:0:0:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:0:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:0:1) Synchronous at 160.0 Mbyte/sec, offset 63.
(scsi0:0:0:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:0:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:0:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
  Vendor: SEAGATE   Model: ST39204LW         Rev: 0002
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:0:1:1) Synchronous at 160.0 Mbyte/sec, offset 63.
(scsi0:0:1:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:1:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:1:1) Synchronous at 160.0 Mbyte/sec, offset 63.
(scsi0:0:1:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:1:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
(scsi0:0:1:1) CHECK_CONDITION on REQUEST_SENSE, returning an error.
scsi : detected 2 SCSI disks total.
(scsi0:0:0:0) Synchronous at 160.0 Mbyte/sec, offset 63.
