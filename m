Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTIMDYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 23:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTIMDYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 23:24:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262006AbTIMDYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 23:24:06 -0400
Message-ID: <3F628DC7.3040308@pobox.com>
Date: Fri, 12 Sep 2003 23:23:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: libata update posted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some minor updates.  The main one is that ATA software reset is now 
considered reliable, so it is now the default. 
Execute-Device-Diagnostic bus reset method remains in place and can be 
easily re-enabled with a flag.

libata has also moved (slightly) to a new home:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/

The latest libata patches for 2.4.x and 2.6.x were uploaded to this URL, 
and future patches will appear in the same location.

Look for more updates this weekend, including bug fixes from Dell and 
Red Hat, and better MMIO support.  And maybe a special surprise.  :)

	Jeff



