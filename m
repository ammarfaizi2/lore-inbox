Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRB1NwG>; Wed, 28 Feb 2001 08:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRB1Nv4>; Wed, 28 Feb 2001 08:51:56 -0500
Received: from smtppop1pub.gte.net ([206.46.170.20]:27993 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S130167AbRB1Nvt>; Wed, 28 Feb 2001 08:51:49 -0500
Message-ID: <3A9D026D.3D5E3CE7@gte.net>
Date: Wed, 28 Feb 2001 08:51:41 -0500
From: Stephen Clark <sclark46@gte.net>
Reply-To: sclark46@gte.net
Organization: Paradigm 4
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Undo Loss msgs from 2.4.2ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feb 28 08:20:23 pc-sec kernel: Undo loss 24.96.49.185/22 c2 l0 ss2/65535
p0
Feb 28 08:22:12 pc-sec kernel: Undo loss 24.96.49.185/22 c2 l0 ss2/65535
p0

Can anyone tell me what these messages mean? It looks like they are
coming from
tcp_input.c:tcp_try_undo_recovery

Should I worry about them?

PCI: Found IRQ 12 for device 00:09.0
eth0: ADMtek Comet rev 17 at 0xe800, 00:20:78:06:94:8E, IRQ 12.

Using 8139too driver.

TIA,
Steve

