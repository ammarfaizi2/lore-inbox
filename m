Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTLLAnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTLLAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:43:21 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:12265 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264434AbTLLAnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:43:09 -0500
Message-ID: <003e01c3c048$ebc59a40$0716a8c0@carbon>
From: "Rob Roschewsk" <ka2pbt@arrl.net>
To: <linux-kernel@vger.kernel.org>
References: <20031211222311.GH15401@matchmail.com> <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com> <20031211230511.GI15401@matchmail.com>
Subject: shm
Date: Thu, 11 Dec 2003 19:43:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
    I need some pointers for using shared memory .... if this isn't the
place to ask then certainly suggest another.

Assume I have all of the physical RAM I need ... I want to be able to use
the maximum amount of shared memory for memory mapped files. I'm guessing
the largest SHM segment I can expect is 4GB .. correct???

What else competes for shared memory??? (ramdisks??? initrd???)

Any help would be appreciated.

Thanks,

Rob

