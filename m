Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUBWPga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUBWPga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:36:30 -0500
Received: from [207.111.197.98] ([207.111.197.98]:63245 "EHLO www.igotu.com")
	by vger.kernel.org with ESMTP id S261925AbUBWPg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:36:28 -0500
From: "Martin Bogomolni" <martinb@www.igotu.com>
To: linux-kernel@vger.kernel.org
Reply-To: martinb@igotu.com
Subject: Is LOADLIN still viable for 2.6?
Date: Mon, 23 Feb 2004 10:05:58 -0500
Message-Id: <20040223145740.M2949@www.igotu.com>
X-Mailer: Open WebMail 2.21 20031110
X-OriginatingIP: 12.100.203.195 (martinb)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When trying to load a 2.6 kernel from a FreeDOS environment, I am now very
consistently unable to load the kernel and an initial ramdisk via LOADLIN.  

The nature of the embedded system I'm working with, requires that DOS be
present prior to loading linux during an interactive startup and hardware
intialization phase.  

Since it doesn't seem that Hans Lermen has been updating or maintaining
loadlin since the release of 2.4 is there anyone who is continuing to maintain
LOADLIN, or has it fallen by the wayside?   Due to the nature of the system,
and a requirement for backwards compatibility and user interaction during
startup, I cannot use Peter Anvin's SYSLINUX linux loader which occurs too
early on in the process.

Are there any other options to startup a linux environment from DOS?




