Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbTCYL0s>; Tue, 25 Mar 2003 06:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCYL0s>; Tue, 25 Mar 2003 06:26:48 -0500
Received: from horse.idknet.com ([217.19.208.18]:17315 "EHLO horse.idknet.com")
	by vger.kernel.org with ESMTP id <S261937AbTCYL0g>;
	Tue, 25 Mar 2003 06:26:36 -0500
X-AV-Checked: Tue Mar 25 13:37:41 2003 OK
Date: Tue, 25 Mar 2003 13:37:41 +0200
From: MaxiM Basunov <maxim@idknet.com>
X-Mailer: The Bat! (v1.60) Personal
Reply-To: MaxiM Basunov <maxim@idknet.com>
Organization: JSCC Interdnestrcom
X-Priority: 3 (Normal)
Message-ID: <1275572723.20030325133741@idknet.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19 kernel and Intel SE7500WV2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andre.

  I need to install Linux on Intel SE7500WV2 with integrated Promise
  FastTrak TX2000 Lite, mirror over 2 IDE disks on RAID.

  After loading, kernel hangs up with error: Bad EIP value.
  First line of call trace says about:
  [<c01c0243> pdc202xx_tune_drive [kernel] 0x383 (0xc44c5f00))

  I tries different kernels. Same errors on all RedHat 80 kernels.

  If TX2000 does not containt ANY IDE disk, kernel works OK, but if any ide
  drive connected, kernel hangs after detecting drive.

  Can you help me with this?
  
-- 
WBR, MaxiM                          mailto:maxim@idknet.com
JSCC Interdnestrcom
Tiraspol, Moldova
www.idknet.com, www.isp.idknet.com

