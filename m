Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVADOF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVADOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVADOF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:05:28 -0500
Received: from www.linux4media.com ([213.133.97.116]:64732 "EHLO archimedis.tv")
	by vger.kernel.org with ESMTP id S261180AbVADOF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:05:26 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-mm1: Keyboard doesn't work after reboot (but after cold start)
Date: Tue, 4 Jan 2005 15:03:00 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501041503.00800.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an Acer Aspire 1501LMi running in 32bit mode, the keyboard doesn't work at 
all after a reboot (but works perfectly after a cold start).

I'm guessing it's an ACPI BIOS bug, but since it works with older kernels, we 
must be doing something different these days.
