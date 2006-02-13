Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWBMGbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWBMGbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWBMGbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:31:55 -0500
Received: from fmr18.intel.com ([134.134.136.17]:47753 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750937AbWBMGby convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:31:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Compaq X1050 multiple suspend problems (ACPI, PS2)
Date: Mon, 13 Feb 2006 14:31:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AE8102B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq X1050 multiple suspend problems (ACPI, PS2)
thread-index: AcYwXnxcdr9/kl4EQna/k4UruBVc+gACGXrA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Feb 2006 06:31:51.0719 (UTC) FILETIME=[2CC01B70:01C63067]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: Compaq X1050 multiple suspend problems (ACPI, PS2)
>
>The following is with a Compaq Presario X1050, Fedora Core 4 
>and Fedora 
>kernel version 2.6.15-1.1831_FC4.
Feb 12 23:15:24 localhost kernel:     ACPI-0412: *** Error: Handler for
[EmbeddedControl] returned AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method
execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method
execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method
execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME

Please try latest base kernel.
