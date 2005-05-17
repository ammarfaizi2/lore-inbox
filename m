Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVEQLuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVEQLuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEQLuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:50:13 -0400
Received: from zukmail03.zreo.compaq.com ([161.114.128.27]:56842 "EHLO
	zukmail03.zreo.compaq.com") by vger.kernel.org with ESMTP
	id S261514AbVEQLsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:48:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: What is needed to boot 2.6 on opteron dual core
Date: Tue, 17 May 2005 13:48:13 +0200
Message-ID: <213219CA6232F94E989A9A5354135D2F0936FE@frqexc04.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What is needed to boot 2.6 on opteron dual core
Thread-Index: AcVaOTPuJBDXZfK3SY6HfVgSTl9F8QAnGU5g
From: "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 May 2005 11:48:14.0127 (UTC) FILETIME=[4EC9B3F0:01C55AD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml,

I am trying to boot a dual core Opteron box with linux 2.6 and it is
crashing very early (swapper process dies, backtrace shows SMP_boot....
Stuff) and I was wondering what patches are needed to boot a 2.6 kernel
on a dual core machine.

I tried 2.6.11.9, 2.6.12-rc4 and 2.6.11-ac7 with the same error. It is
difficult for me to copy the output since this is a workstation and not
a server but I can give details if my question does not make sense. 

Thanks in advance.

The machine works fine with redhat 3 update 5 I think but it is 2.4
based.
