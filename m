Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUBND33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 22:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUBND33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 22:29:29 -0500
Received: from mail.zero.ou.edu ([129.15.0.75]:6876 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id S264565AbUBND32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 22:29:28 -0500
Date: Fri, 13 Feb 2004 21:26:31 -0600
From: "Stephen M. Kenton" <skenton@ou.edu>
Subject: Re: Kernel Cross Compiling
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <402D9567.B5044EFE@ou.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD NSCPCD47  (Win98; I)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problems with GCC cross builds are known and are
targeted for GCC 3.5 since the changes will apparently be
invasive.  If you have not seen it yet, Dan Kegel has
a very nice package called crosstool with lots of
comments about the contortions of cross compiling.
http://kegel.com/crosstool

smk
