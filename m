Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270924AbUJUUCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270924AbUJUUCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbUJUT6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:58:15 -0400
Received: from web51810.mail.yahoo.com ([206.190.38.241]:62066 "HELO
	web51810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270812AbUJUTyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:54:03 -0400
Message-ID: <20041021195402.53179.qmail@web51810.mail.yahoo.com>
Date: Thu, 21 Oct 2004 12:54:02 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: qla2300 and 2.6.x proc file system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was looking at using 2.6.x with qla2300 FC cards and
found that the proc FS has changed some.  In
particular, I can not seem to find any control for the
qla2300 cards I have where it was under
/proc/scsi/qla2300 in the 2.4.x kernels.  I need the
interface so I can rescan looking for changes.  I am
curious, does the qla driver which is part of 2.6.x
not have a proc interface or am I doing something
incorrectly?

BTW, I see the kernel found the cards and volumes on
the SAN and that it assigns block devs to these and
that the local MPT scsi driver ends up with a proc at
/proc/mpt. 

Thanks for the help!
Phy


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
