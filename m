Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUCKT5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUCKT5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:57:34 -0500
Received: from tag.witbe.net ([81.88.96.48]:54030 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261685AbUCKT5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:57:33 -0500
Message-Id: <200403111957.i2BJvWA29773@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <Valdis.Kletnieks@vt.edu>, "'pg smith'" <pete@linuxbox.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: LKM rootkits in 2.6.x 
Date: Thu, 11 Mar 2004 20:57:25 +0100
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200403111939.i2BJdxrx004553@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcQHoQUa8lUwoGkSQLCJpBcB9039NwAAfHJA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Subject: Announcing full functional adore-ng rootkit for 2.6 Kernel
> From: stealth <stealth@segfault.net>
> Date: Thu, 11 Mar 2004 10:27:00 +0000
> To: bugtraq@securityfocus.com
> 
> Hi,
> 
> At http://stealth.7350.org/rootkits/adore-ng-0.41.tgz you find
> the complete port of adore-ng for the Linux kernel 2.6. All
> of the stuff you know from earlier kernel 2.4 versions such

>From the FEATURES file :
 o does not utilize sys_call_table but VFS layer

Seems to be that easy... Should we hide VFS layer now :-)

Regards,
Paul


