Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUGNIpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUGNIpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUGNIpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:45:38 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:53480 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S267323AbUGNIph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:45:37 -0400
Message-ID: <30a4d01b04071401457267defa@mail.gmail.com>
Date: Wed, 14 Jul 2004 11:45:29 +0300
From: Genady Okrain <mafteah@gmail.com>
To: akpm@osdl.org
Subject: Can't compile sg.c 2.6.8-rc1-mm1
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using gcc-3.4.1

  CC [M]  drivers/scsi/sg.o
drivers/scsi/sg.c: In function `sg_ioctl':
drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call
to 'sg_jif_to_ms': function body not available
drivers/scsi/sg.c:930: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/sg.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

-- 
Genady Okrain AKA Mafteah
