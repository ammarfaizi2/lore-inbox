Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTLLA4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLLA4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:56:51 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:4787 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264436AbTLLA4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:56:50 -0500
Message-ID: <000001c3c04a$d47842f0$0716a8c0@carbon>
From: "Rob Roschewsk" <ka2pbt@comcast.net>
To: <linux-kernel@vger.kernel.org>
References: <20031211222311.GH15401@matchmail.com> <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com> <20031211230511.GI15401@matchmail.com>
Subject: shm
Date: Thu, 11 Dec 2003 19:45:37 -0500
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

