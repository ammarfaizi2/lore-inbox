Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVANAge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVANAge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVANAgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:36:14 -0500
Received: from mailgate.Cadence.COM ([158.140.2.1]:10706 "EHLO
	mailgate.Cadence.COM") by vger.kernel.org with ESMTP
	id S261720AbVANAfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:35:12 -0500
Message-Id: <6.1.2.0.2.20050113163537.03cb9208@mailhub>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Thu, 13 Jan 2005 16:36:23 -0800
To: linux-kernel@vger.kernel.org
From: Mitch Sako <msako@cadence.com>
Subject: libata 2.6.10 limitation?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is there a limitation to the number of SATA drives for libata that can be 
>loaded to a 32bit Intel machine running 2.6.10?  I'm trying to setup six 
>JBOD drives using 3 Promise cards or 3 Silicon Image cards or 2 Promise 
>TX4 cards and I'm seeing a problem with /dev/sde (the fifth drive out of 
>six) only.  I'm getting SCSI errors and machine hangs on the fifth drive only.


