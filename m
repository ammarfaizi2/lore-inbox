Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVBRTNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVBRTNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVBRTNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:13:52 -0500
Received: from fmr19.intel.com ([134.134.136.18]:5092 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261453AbVBRTNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:13:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/net/ixgb/: possible cleanups
Date: Fri, 18 Feb 2005 10:38:36 -0800
Message-ID: <468F3FDA28AA87429AD807992E22D07E0450779A@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/net/ixgb/: possible cleanups
Thread-Index: AcUVMp+hOg6VVQ75RSKguCzDBKvcWwAtdvdw
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>,
       "Veeraiyan, Ayyappan" <ayyappan.veeraiyan@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Cc: <jgarzik@pobox.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Feb 2005 18:38:40.0240 (UTC) FILETIME=[10BE5700:01C515E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This patch contains the following possible cleanups:

Thanks for the comments. Although all your comments are valid, we will
not be able to apply your patch as is. This is because of the way we
have set up our source code (some of which is shared with non-GPL code).
We will submit a patch that addresses all the issues you've raised here.

We will apply your patch to ixgb_main.c as is.

Thanks,
Ganesh.

