Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTDFAid (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 19:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbTDFAic (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 19:38:32 -0500
Received: from lloyd-169.caltech.edu ([131.215.89.169]:65410 "HELO
	homer.d-oh.org") by vger.kernel.org with SMTP id S262740AbTDFAic (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 19:38:32 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: VFS-Lock patch
Date: Sat, 5 Apr 2003 16:50:03 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOAECGDAAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm just curious, is there any reason why the VFS-lock patch provided by the
LVM people has not been included into the 2.4.x tree yet?

If I were to apply this patch to a stock 2.4.20 kernel, is it safe to use
LVM snapshots with ReiserFS on production machines, or are there any
stability issues with it (either with the LVM version that comes with
2.4.20, or upgrading to LVM 1.0.7)?

Thanks,

Alex

