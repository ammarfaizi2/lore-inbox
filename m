Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRLVSv3>; Sat, 22 Dec 2001 13:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLVSvT>; Sat, 22 Dec 2001 13:51:19 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.226]:21976 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S281806AbRLVSvF>; Sat, 22 Dec 2001 13:51:05 -0500
Message-ID: <3C24D5F1.3FF73EE0@nyc.rr.com>
Date: Sat, 22 Dec 2001 13:50:25 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 OOPS: on Boot loading floppy driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone else seeing this problem on boot?  I apologize for not giving the
full oops, but I'm not sure how to get at the oops since it happens on
boot (and I'm sorry to not have anything to attach to the serial port as
per the oops-tracing.txt).

FDC 0 is an 8272A
Unable to handle kernel paging request at virtual address 0000413d
 print eip:
c0106ea6
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0106ea6>]    Not tained
EFLAGS: 00010286
