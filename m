Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTBOSOG>; Sat, 15 Feb 2003 13:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBOSOG>; Sat, 15 Feb 2003 13:14:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15001 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264788AbTBOSOF> convert rfc822-to-8bit; Sat, 15 Feb 2003 13:14:05 -0500
Date: Sat, 15 Feb 2003 10:23:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 359] New: eth0: Too much work at interrupt, IntrStatus=0x0001
 at network shutdown
Message-ID: <1040000.1045333434@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=359

           Summary: eth0: Too much work at interrupt, IntrStatus=0x0001 at
                    network shutdown
    Kernel Version: 2.5.61
            Status: NEW
          Severity: low
             Owner: jgarzik@pobox.com
         Submitter: Nicolas.Mailhot@LaPoste.net


Distribution: Red Hat Raw Hide (15.2.2003)

Hardware Environment:  http://www.giga-byte.com/products/7vax.htm (Via KT
400 + Via VT 8235 + Realtek RTL8100BL), F9 bios
Problem Description: when the network is shut down I get pages of « Too much
work at interrupt, IntrStatus=0x0001 »

Steps to reproduce: service network stop, system shutdown...


