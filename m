Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUL2VNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUL2VNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUL2VNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:13:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:49874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261467AbUL2VNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:13:37 -0500
X-Authenticated: #20477425
From: Micha <micha-1@fantasymail.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ide problem...
Date: Wed, 29 Dec 2004 22:13:34 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412292213.34517.micha-1@fantasymail.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an error reading a dvd with 2.6.9 and ide interface. Switching to 
ide-scsi for the dvd-rom made the dvd work. Is this an ide-error? I think 
libdvdread should not know wether it's reading a scsi or a ide device...

 Michael
