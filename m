Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUBDVOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUBDVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:12:15 -0500
Received: from mail.bbb2.mdc-berlin.de ([141.80.34.25]:34826 "EHLO
	mail.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S266509AbUBDVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:11:24 -0500
Subject: imm.ko and linux-2.6.1 or linux-2.6.2
From: Juergen Rose <rose@rz.uni-potsdam.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Max-Delbrueck-Zentrum
Message-Id: <1075929081.30698.76.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 22:11:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am very satisfied with the imm driver, when I am using it with
linux-2.4.*, everything is working fine. But using imm.ko together with
linux-2.6.1 or linux-2.6.2 I get:
 
imm: Version 2.05 (for Linux 2.4.0)
imm: parport reports no devices.
FATAL: Error inserting imm
(/lib/modules/2.6.2/kernel/drivers/scsi/imm.ko): No such device

if I perform 'modprobe imm'. I can't reach the email address in imm.c
(<campbell@torque.net>... User unknown).  Do you have any hint for me?

        Regards Juergen

P.S. Please send answers also to my email address.
-- 
Juergen Rose <rose@rz.uni-potsdam.de>
Max-Delbrueck-Zentrum

