Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbTC1D6d>; Thu, 27 Mar 2003 22:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbTC1D6c>; Thu, 27 Mar 2003 22:58:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43222 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262178AbTC1D6b>; Thu, 27 Mar 2003 22:58:31 -0500
Date: Thu, 27 Mar 2003 20:09:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 515] New: kernel panics when bttv compiled in
Message-ID: <28030000.1048824585@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=515

           Summary: kernel panics when bttv compiled in
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ryan@ocf.berkeley.edu


Distribution: Debian GNU/Linux sid i386

Hardware Environment:
 Miro PCTV card
 2x 1 GHz Pentium III
 Asus P2B-D motherboard

Software Environment:
 Before /sbin/init

Problem Description:
 With bttv compiled into the kernel, it panics at boot.
 The last thing it prints before the kernel dumps its messages is:

  bttv: Host bridge needs ETBF enabled.

Steps to reproduce:
 Just booting with the kernel.

