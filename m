Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVBZHyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVBZHyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 02:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVBZHyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 02:54:22 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:8889 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261743AbVBZHyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 02:54:20 -0500
Date: Sat, 26 Feb 2005 13:24:36 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: calling call_usermodehelper from interrupt context
Message-ID: <Pine.LNX.4.60.0502261319130.31181@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai all,
     Is it possible to call call_usermodehelper from interrupt context.
I want to call a user program from the keyboard driver. When am calling, 
it is hanging, and giving the error that
    <0> Kernel panic : Aiee, killing interrupt handler
        In interrupt handler -- not syncing.
I am using Redhat linux 9.

Can anybody please help me.


  Thanks&Regards,

   P.Manohar,

