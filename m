Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUKLSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUKLSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbUKLSTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:19:24 -0500
Received: from smtp7.dti.ne.jp ([202.216.228.42]:15320 "EHLO smtp7.dti.ne.jp")
	by vger.kernel.org with ESMTP id S262596AbUKLSSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:18:25 -0500
Message-ID: <004401c4c8e3$fb077d80$7bbdbd09@TPHIROIT>
From: "Hiroshi Itoh" <hiroit@mcn.ne.jp>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>,
       "Len Brown" <len.brown@intel.com>
References: <1099986428.6090.53.camel@d845pe> <20041112174248.GA4267@openzaurus.ucw.cz>
Subject: Re: [ACPI] Re: [BKPATCH] ACPI for 2.6
Date: Sat, 13 Nov 2004 03:18:15 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>    Useful to workaround C3 ipw2100 packet loss,
>>    reducing noise or boot issues on some models.
>>    http://bugme.osdl.org/show_bug.cgi?id=3549
>>    
>>    For static processor driver, boot cmdline:
>>    processor.acpi_cstate_limit=2

>You certainly win "ugliest parameter of the month" contest :-).
>What about processor.max_cstate= or something?

Always you are not so gentle, but often cool. :-)

-Hiro
