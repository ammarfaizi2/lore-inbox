Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUFGIiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUFGIiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFGIiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:38:20 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:29390 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S262279AbUFGIiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:38:13 -0400
Message-ID: <20040607083809.14677.qmail@team.outblaze.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Timothy Webster" <timothyw@outblaze.com>
To: linux-kernel@vger.kernel.org
Cc: timothyw@outblaze.com
Date: Mon, 07 Jun 2004 16:38:09 +0800
Subject: Porting cpqhealth to v2.6
X-Originating-Ip: 210.177.227.130
X-Originating-Server: int.hk.outblaze.com
X-Habeas-Swe-1: winter into spring
X-Habeas-Swe-2: brightly anticipated
X-Habeas-Swe-3: like Habeas SWE (tm)
X-Habeas-Swe-4: Copyright 2002 Habeas (tm)
X-Habeas-Swe-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-Swe-6: email in exchange for a license for this Habeas
X-Habeas-Swe-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-Swe-8: Message (HCM) and not spam. Please report use of this
X-Habeas-Swe-9: mark in spam to <http://www.habeas.com/report/>.
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.25.0.61; VDF: 6.25.0.85; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone ported the compaq/hp Proliant health drivers to 
the 2.6 kernel? 
 
Thanks to Kianusch Sayah Karadji, I have a nice build script 
http://www.sk-tech.net/support/HPrpm2deb.sh.html 
 
But these cpqhealth modules only work for 2.4 kernels. 
 
 
The driver source is available from 
ftp.compaq.com/pub/products/servers/supportsoftware/linux/ 
hpasm-7.1.0-xx.xxx.i386.rpm 
 
The modules that need to be ported from2.4 to 2.6 are 
opt/compaq/cpqhealth/{cmhp,cqpasm,cpqevt} 
 
 
-thanks in advance. 
 
Timothy Webster 
 
Outblaze Ltd. 
 
 
 
 
 
 
 
