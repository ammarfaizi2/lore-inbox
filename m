Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263833AbRFDSiB>; Mon, 4 Jun 2001 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbRFDShm>; Mon, 4 Jun 2001 14:37:42 -0400
Received: from palrel2.hp.com ([156.153.255.234]:13778 "HELO palrel2.hp.com")
	by vger.kernel.org with SMTP id <S263833AbRFDSh0>;
	Mon, 4 Jun 2001 14:37:26 -0400
Message-ID: <6BD67FFB937FD411A04F00D0B74FE87804308CF5@xrose06.rose.hp.com>
From: "YU,SAMMY (HP-Roseville,ex1)" <sammy_yu@hp.com>
To: linux-kernel@vger.kernel.org
Subject: I/O tracing
Date: Mon, 4 Jun 2001 11:37:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Please CC me as I'm not subscribed on the list, thanks.  Not sure if
this is appropriate forum, is there an existing tool/module for capturing
all the I/O requests such as:

Unique Identifier
Start Time
End Time
Device Identifier
Operation Type (Read Or Write)
Offset
Length (Number Of Bytes)

I am aware of existing /proc/disks and partitions, but these aren't real
time.  If not, are there any facilities in the kernel I can put a hook in to
keep track of the I/O?


Thanks in advance,
Sammy Yu
Hewlett-Packard

