Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJAUXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJAUXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJAUVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:21:09 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:4115 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S266352AbUJAUQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:16:51 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Al Borchers'" <alborchers@steinerpoint.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-usb-devel'" <linux-usb-devel@lists.sourceforge.net>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: new locking in change_termios breaks USB serial drivers
Date: Fri, 1 Oct 2004 16:15:29 -0400
Organization: Connect Tech Inc.
Message-ID: <010801c4a7f3$65e674b0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <415D84A3.6010105@steinerpoint.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> Its a design decision for the tty layer.  You should choose 
> whatever is
> best there and the drivers will have to adapt.

I agree.

..Stu

