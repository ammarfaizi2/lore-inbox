Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFBN0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFBN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVFBN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:26:25 -0400
Received: from helium.prodar.com.br ([200.247.36.2]:41108 "EHLO
	helium.prodar.com.br") by vger.kernel.org with ESMTP
	id S261403AbVFBN0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:26:23 -0400
Subject: SATA abnormal status 0x80 on port 0x177
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: jgarzik@redhat.com, dfadel@ferasoft.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: Ferasoft Corporation Ltda - ME
Date: Thu, 02 Jun 2005 13:26:50 +0000
Message-Id: <1117718810.7171.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello kernel hackers!

I run kernel 2.6.10 on Dell Power Edge Server with 
512 MB RAM and two sata disk of 80GB.

At my syslogs and dmesg i get this errors:

SCSI error : <2 0 0 0> return code = 0x8000002
FMK Current sdb: sense = 70 80
end_request: I/O error, dev sdb, sector 273863559
ATA: abnormal status 0x80 on port 0x177
ATA: abnormal status 0x80 on port 0x177
ATA: abnormal status 0x80 on port 0x177
ata1: command 0x25 timeout, stat 0x50 host_stat 0x21
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1

Any idea?

Best Regards!

-- 
Fernando Alencar Maróstica <famarost@unimep.br>
Ferasoft Corporation Ltda - ME

