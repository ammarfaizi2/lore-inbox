Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTLCPKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTLCPKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:10:07 -0500
Received: from mail.siemenscom.com ([12.146.131.10]:20644 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S264584AbTLCPKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:10:04 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 
Date: Wed, 3 Dec 2003 07:08:38 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to open a non-existan device driver node file. The Kernel returns a
value of -1 (expected). However, when I read the value of errno it contains
a value of 29. A call to the perror functrion does print out the correct
error message (a value of 2). Why does this happen?

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

