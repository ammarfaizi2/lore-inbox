Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSI0N3a>; Fri, 27 Sep 2002 09:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261658AbSI0N3a>; Fri, 27 Sep 2002 09:29:30 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:12295 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S261615AbSI0N3a>; Fri, 27 Sep 2002 09:29:30 -0400
Message-ID: <3D945F48.5DC9D233@compro.net>
Date: Fri, 27 Sep 2002 09:38:16 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT]Raw Disk Support?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry if this is the wrong place to ask. Just figured you all would know the
answer for sure.

I have a need for an application I'm writing to be able to read raw data from
scsi disk drives that were used on an old Proprietary OS. (MPX-32). These disks
are formatted at a 768 byte sector size. All disks using this OS were formatted
at a 768 byte sector. Is there any way that I can read the raw 768 byte sectors
with Linux?

I guess first, will a Linux scsi driver let me read 768 byte sectors and second
is there raw disk device support such that I can read these disks without a
known filesystem type being on them?

Thanks in advance and Regards

Mark
