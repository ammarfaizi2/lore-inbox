Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUGSV2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUGSV2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUGSV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 17:28:48 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:51826 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S264229AbUGSV2j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 17:28:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Ramdisk encryption
Date: Mon, 19 Jul 2004 17:28:38 -0400
Message-ID: <951A499AA688EF47A898B45F25BD8EE80126D4CB@mailer.nec-labs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ramdisk encryption
Thread-Index: AcRt0fkDesJ9FDIoRjmHh7HySOUIcgABTChQ
From: "Lei Yang" <leiyang@nec-labs.com>
To: "Andreas Jellinghaus" <aj@dungeon.inka.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot! I'll try and let you know the result.
I also think it should work on ramdisk, just want to know how it really works internally to help better understand. Any recommended readings or materials?

Lei

-----Original Message-----
From: Andreas Jellinghaus [mailto:aj@dungeon.inka.de]
Sent: Monday, July 19, 2004 4:44 PM
To: Lei Yang
Cc: linux-kernel@vger.kernel.org
Subject: RE: Ramdisk encryption


I never tried it, but I see no reason, why dm-crypt shouldn't work
on top of a ramdisk too. If you have any trouble with it, there
is a dm-crypt mailing list, and the author is very responsive.

Andreas


