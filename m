Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVCQUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVCQUHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVCQUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:07:53 -0500
Received: from fmr18.intel.com ([134.134.136.17]:40375 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261812AbVCQUHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:07:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: KGDB question
Date: Thu, 17 Mar 2005 12:06:27 -0800
Message-ID: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: KGDB question
Thread-Index: AcUrLM2sJGf5g7atTr+46gD85YOopQ==
From: "Abhinkar, Sameer" <sameer.abhinkar@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Mar 2005 20:07:45.0805 (UTC) FILETIME=[FC1A13D0:01C52B2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!
 
I am very new to Linux kernel and if this is a question which is not for
this mailing list, please let me know.
 
I am trying to debug the kernel 2.6.11.2 with KGDB. I was able to
successfully debug linux kernel 2.6.7 on two machines (a P3, running as
a development machine, and the other is a dual Xeon 32-bit running as a
test machine) but I'm not able to configure 2.6.11.2 to enable KGDB.
There are no options available to enable KGDB (as opposed to 2.6.7) when
I run 'make menuconfig'. The kgdb.sourceforge.net site has kgdb patch
for 2.6.7 and not for later versions. Are there any patches or hooks
available to enable KGDB for linux-2.6.11.2? 
 
I would really appreciate if someone could guide on the above query?
 
Thanks for your help,
 
Sameer
