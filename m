Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbULETXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbULETXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbULETXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:23:20 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:63108 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261365AbULETXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:23:17 -0500
Message-ID: <41B36021.5050600@keyaccess.nl>
Date: Sun, 05 Dec 2004 20:23:13 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart.

I see your 2004-11-01 IDE update:

http://lkml.org/lkml/2004/11/1/158

obsoleted the idex=ata66 option, saying that it "should be handled by 
host drivers needing it". As far as I can see, amd74xx does not handle this?

I do need a way to force an 80c cable on this AMD756 (ATA66 max) board, 
since the BIOS doesn't seem to be setting the cable bits correctly.

Regards,
Rene.

