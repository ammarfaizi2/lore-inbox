Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFTCW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTFTCW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:22:59 -0400
Received: from fmr02.intel.com ([192.55.52.25]:44005 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262169AbTFTCW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:22:58 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040A10@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'mochel@osdl.org'" <mochel@osdl.org>,
       "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2.5.72] Fix boot deadlock on MTRR main.c:ipi_handler
Date: Thu, 19 Jun 2003 19:32:46 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Perez-Gonzalez, Inaky [mailto:inaky.perez-gonzalez@intel.com]
>
> Sooo .. decided to do the binary search thingie and tracked
> it down to patch-2.5.70-bk15-bk15.gz, change set 1.28
>
(http://linux.bkbits.net:8080/linux-2.5/diffs/arch/i386/kernel/cpu/mtrr/main
> .c@1.28?nav=index.html|tags|ChangeSet@1.1215.18.33..|cset@1.1215.114.28),

God I hate Outlook ...

http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.114.28

And seems the cset is not 1.28 ... kind of complex this BK thing

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
