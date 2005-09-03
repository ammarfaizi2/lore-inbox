Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVICQMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVICQMF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVICQMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:12:05 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:17565 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751471AbVICQME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:12:04 -0400
Date: Sat, 03 Sep 2005 18:12:02 +0200
Message-Id: <915044729@web.de>
MIME-Version: 1.0
From: Lars Ziegler <lziegler@web.de>
To: linux-kernel@vger.kernel.org
Subject: sym53c8xx_2 scsi parity error
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

two weeks ago I just installed an Dawicontrol DC2976 UW SCSI controller an an HP C7438 DAT streamer in my pc. I'm running a SuSE 9.3 Prof distribution with Kernel 2.6.13. when taking backups to my dat no error occurs. but when i try to rebackup data from streamer to my hd i always get scsi parity errors and the process is stopped. I tried different patches for the sym53c8xx_2 driver but no patch solved my problems. has any body an idea what i can do to get my dat work.
Thanks a lot!
Lars
_________________________________________________________________________
Mit der Gruppen-SMS von WEB.DE FreeMail können Sie eine SMS an alle 
Freunde gleichzeitig schicken: http://freemail.web.de/features/?mc=021179



