Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWBUXlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWBUXlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBUXlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:41:01 -0500
Received: from tomts36.bellnexxia.net ([209.226.175.93]:17897 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932175AbWBUXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:41:00 -0500
Message-ID: <43FBA4CD.6000505@torque.net>
Date: Tue, 21 Feb 2006 18:39:57 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, taggart@debian.org
Subject: lsscsi-0.17 released
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsscsi is a utility that uses sysfs in linux 2.6 series kernels
to list information about SCSI devices and SCSI hosts. Both a
compact format (default) which is one line per device and a
"classic" format (like the output of 'cat /proc/scsi/scsi') are
supported.

Version 0.17 is available at
http://www.torque.net/scsi/lsscsi.html
More information can be found on that page including examples
and a Download section for tarballs and rpms.
This version will be required for lsscsi to work properly
when lk 2.6.16 is released.

ChangeLog:
Version 0.17 2006/2/6
  - fix disappearance of block device names in lk 2.6.16-rc1

Doug Gilbert
