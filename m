Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269128AbTCBHg2>; Sun, 2 Mar 2003 02:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbTCBHg2>; Sun, 2 Mar 2003 02:36:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6324 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269128AbTCBHg2>; Sun, 2 Mar 2003 02:36:28 -0500
Date: Sat, 01 Mar 2003 23:46:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 424] New: USB Microsoft IntelliMouse does not work with latest 2.5.63-bk 
Message-ID: <8620000.1046591210@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=424

           Summary: USB Microsoft IntelliMouse does not work with latest
                    2.5.63-bk
    Kernel Version: latest 2.5.63-bk
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: khromy@lnuxlab.ath.cx


Distribution:
Hardware Environment:
Software Environment:
Problem Description:
USB mouse does not work with latest 2.5.63-bk, works fine with 2.5.62-mm2.

CONFIG_USB=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y


