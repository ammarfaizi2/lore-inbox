Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264419AbTCXVCg>; Mon, 24 Mar 2003 16:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264420AbTCXVCg>; Mon, 24 Mar 2003 16:02:36 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:13267 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264419AbTCXVCd>; Mon, 24 Mar 2003 16:02:33 -0500
Date: Mon, 24 Mar 2003 13:03:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 495] New: Logitech USB cordless optical trackball no longer works
Message-ID: <541570000.1048539830@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=495

           Summary: Logitech USB cordless optical trackball no longer works
    Kernel Version: 2.5.65-bk4
            Status: NEW
          Severity: high
             Owner: greg@kroah.com
         Submitter: davidvh@cox.net


Distribution:

RedHat 8.0

Hardware Environment:

Asus P4S8X motherboard w/ Northwood Pentium 4 2.53GHz
Logitech USB cordless optical trackball

Software Environment:

N/A

Problem Description:

Since 2.5.64, my trackball is no longer working.
On bootup, a single message about a new USB device being found is displayed, but
the typical HID input response never appears and the trackball doesn't work.
I get the below message later:
drivers/usb/core/message.c: usb_control/bulk_msg: timeout

Steps to reproduce:

Never works.


