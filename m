Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268679AbTCAPro>; Sat, 1 Mar 2003 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268701AbTCAPro>; Sat, 1 Mar 2003 10:47:44 -0500
Received: from collamer.mail.atl.earthlink.net ([199.174.114.9]:13097 "EHLO
	collamer.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id <S268679AbTCAPro>; Sat, 1 Mar 2003 10:47:44 -0500
From: "Stephen Corey" <s_corey@netzero.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel tuning for high latency satellite link??
Date: Sat, 1 Mar 2003 10:58:46 -0500
Message-ID: <000001c2e00b$71bb7d50$0301a8c0@corey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I need to tune the linux kernel (2.4.18-3) for high latency
connections? I'm installing a linux box on a satellite link (~800 ms
roundtrip latency). Will the kernel *automatically* change anything
based on latency, to hurt my throughput performance??

