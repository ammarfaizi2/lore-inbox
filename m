Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVGKUdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVGKUdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVGKUcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:32:20 -0400
Received: from web33113.mail.mud.yahoo.com ([68.142.206.94]:29838 "HELO
	web33113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262586AbVGKUas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:30:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XBlKusLStLJnrmQgTu3Ns6YczM2CnOOdNOCf0L6l39B4QN5QHJgtWXRX8GEDjiofV4nObGryyyA/arxtyE19cnnyfqIN1qR3ITTI7j365Yk3VZtwTnfl4L1nfWuXSyQtjCzj2Ea3kDGIz/EKEn/CgBCuZzBdER3kIRXtuk3c71s=  ;
Message-ID: <20050711203047.39437.qmail@web33113.mail.mud.yahoo.com>
Date: Mon, 11 Jul 2005 13:30:47 -0700 (PDT)
From: Joe Sevy <jmsevy@yahoo.com>
Subject: usb mass storage bug
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, no logs or dmesg to report; just performance.
Using kernel 2.6.12: USB flash drive (san-disk cruzer
micro) Copy FROM drive is normal and quick; copy TO
drive is amazingly slow. (30 minutes for 50K file).
Used same configuration as for 2.6.11.11. Cured by
going back to old kernel.

Sorry I can't give better report.

Thank you.

Joe Sevy

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
