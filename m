Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVHEHmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVHEHmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVHEHmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:42:22 -0400
Received: from main.gmane.org ([80.91.229.2]:33668 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262893AbVHEHmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:42:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Vadim Yatsenko" <Vadim.Yatsenko@malva.ua>
Subject: initrd load from any block device
Date: Fri, 5 Aug 2005 10:29:42 +0300
Message-ID: <dcv4h8$98n$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: malva-lucky.malva.ua
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-RFC2646: Format=Flowed; Original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

May be it was discussed but I havn't answer.
So my question is: why only supported media to load
initial ramdisk is floppy?

In embedded systems it's more other suitable devices
such as mtdblock, etc. So why not to add some code
to support loading compressed initrd images from
any block device. It's can reduce boot up time.

I've tried to do this on my ARM machine and was
impressed how much faster my board was get alive.

It is usual practice in embedded world to use ramdisk
as a root.

Any comments?

With best regards. Vadim Yatsenko 



