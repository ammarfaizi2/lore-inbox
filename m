Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbTGOPqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268586AbTGOPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:44:55 -0400
Received: from ns.mock.com ([209.157.146.194]:8090 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S268567AbTGOPn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:43:27 -0400
Message-Id: <5.1.0.14.2.20030715084326.077d0480@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Jul 2003 08:58:16 -0700
To: linux-kernel@vger.kernel.org
From: Jeff Mock <jeff-ml@mock.com>
Subject: SCSI ATA driver in 2.4.22 ?
In-Reply-To: <Pine.LNX.4.53.0307151125400.15686@chaos>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
 <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1035; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is Jeff Garzik's SCSI ATA driver going in 2.4.22?  I've been using it
with great success with 2.4.21-ac4, but I haven't seen it in any
of the 2.4.22-pre kernels.

If it's not going in, is there an alternative for accessing serial
ATA devices in native/enhanced mode rather than legacy mode?


By the way, if you name your child libata, some say the name has
some nice qualities:

    http://www.kabalarians.com/male/libata.htm

jeff

