Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTICQSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTICQRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:17:43 -0400
Received: from juniper.cant.ac.uk ([194.66.208.102]:14310 "EHLO
	juniper.canterbury.ac.uk") by vger.kernel.org with ESMTP
	id S263896AbTICQRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:17:02 -0400
Subject: Kernel 2.4: Load average scaling to 200!
From: James Vanns <jimv@canterbury.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Canterbury Christ Church University College
Message-Id: <1062605821.23773.15.camel@eeyore.ntnet.cc.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 17:17:01 +0100
Content-Transfer-Encoding: 7bit
X-Time-on-queue: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 

As I am not sure whether this problem lies with the kernel core (process
scheduler, context switching etc. and all that other stuff that flies
over my head!), a scsi driver or the scsi tape driver or the 'mt'
command itself I have copied the kernel mailing list in this E-mail.

When using mt on RedHat Linux 8 running kernel 2.4.20 to fsf on an LTO
tape drive the load average soars to 100+ and denies everyone the mail
service it's used for (IMAP). I have to reboot the server as I cannot
kill mt. 

Has anyone had this kind of problem before? Any ideas if this is kernel
related (sorry to waste time if you are sure it's not)? I have looked
into mt's history to find no such bug report before.

Regards

James Vanns

-- 
James Vanns BSc (Hons) MCP
Linux Systems Administrator
Senior Software Engineer (Linux / C & C++)
Canterbury Christ Church University College
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x24045370

