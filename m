Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVGSP7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVGSP7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 11:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVGSP7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 11:59:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:35045 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261433AbVGSP7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 11:59:52 -0400
Subject: assignment of major number to serial driver -2.6.x kernels
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 19 Jul 2005 10:53:13 -0500
Message-Id: <1121788393.3756.8.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  I would like to know whether the usage of 253 as major (device) number
in serial port drivers is restricted in 2.6.x kernels.  I am asking this
question, though the documentation tells the driver developers that 253
is a reserved major number, 2.6.x Linux kernels can accommodate more
than 255.

  Also I would like to know the procedure (and related info) to apply
for getting a static number (major/minor) for devices in device drivers.
Is this practice continued still?

  Thanks for your help.

Regards,
V. Ananda Krishnan

