Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266999AbUBEXIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbUBEXHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:07:06 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:55716 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266885AbUBEXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:05:57 -0500
Subject: Re : Re : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Content-Type: text/plain
Organization: Installation Fault
Message-Id: <1076022283.8842.119.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 00:04:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to modify pcm.c, removing the lock_irq/unlock_irq pcm calls but
it doesn't change anything to the problem on my kernel 2.6.2.

Please help a poor beta tester who wants his sound back :D

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

