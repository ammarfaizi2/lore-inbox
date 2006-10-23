Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWJWPYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWJWPYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWJWPYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:24:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:39589 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964936AbWJWPYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:24:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nejv9IHGtl8860VN/2kk61r3hIqYIk6ZsJcgCwEsm5/X8FFPxij3gxSm/NWHsotDZgZlNSl1THni63dzq01pKgfWj/nb+/RHcxXdegUquvZ/BVtjUutGoC1QhM7QXKEA4rMoC0wV9nNK7K//7LyYeTbMhoQT/oNhsSKJX6wwp2w=
Message-ID: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
Date: Mon, 23 Oct 2006 23:24:14 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.19-rc2 tg3 problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
with patching to v3.66 ...

tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
tg3: Cannot find proper PCI device base address, aborting.
ACPI: PCI Interrupt for device 0000:02:00.0 disabled

The last version 2.6.18-rc2 works fine. h/w is Dell Optiplex GX620.

Jeff.
