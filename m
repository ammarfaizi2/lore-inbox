Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSLJTdf>; Tue, 10 Dec 2002 14:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLJTdf>; Tue, 10 Dec 2002 14:33:35 -0500
Received: from delta.acabtu.com.mx ([200.33.20.90]:64389 "EHLO
	delta.acabtu.com.mx") by vger.kernel.org with ESMTP
	id <S265321AbSLJTdf>; Tue, 10 Dec 2002 14:33:35 -0500
Message-ID: <3DF6418F.B73A93E5@acabtu.com.mx>
Date: Tue, 10 Dec 2002 13:33:35 -0600
From: Karina <kgs@acabtu.com.mx>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Trouble with kernel 2.4.18-18.7.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.0(snapshot 20020828) (delta)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i've just installed kernel 2.4.18-18.7.x  (from RPM) and now it
seems there are problems with my scsi devices.
I have attached an adaptec scsi  AIC7XXX adapter, the system detects the
device, but in the logs appears messages: "blk: queue c24afa18, I/0
limit 4095Mb (mask0xfffffff)", these messages didn't appear before with
my old kernel.

Also, there are another messages in the dmesg results:

kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter errno = 2

When i try to list or do something with my tape the message: st0 block
limits 1 - 16777215 bytes appears...

Sorry i'm new in this ?

Is this a bug ? a big one ? should i use instead my old kernel ?

Thanks in advance,

Karina.


