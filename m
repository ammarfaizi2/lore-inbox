Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTCERtz>; Wed, 5 Mar 2003 12:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTCERtz>; Wed, 5 Mar 2003 12:49:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34434 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266939AbTCERty>; Wed, 5 Mar 2003 12:49:54 -0500
Date: Wed, 05 Mar 2003 10:00:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 440] New: Failed to register 'sysfs' in sysfs
Message-ID: <161310000.1046887224@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=440

           Summary: Failed to register 'sysfs' in sysfs
    Kernel Version: 2.5.64
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86

Problem Description:

On boot, I noticed this failure message...

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Failed to register 'sysfs' in sysfs
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K

Steps to reproduce:

