Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbULAPTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbULAPTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbULAPTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:19:41 -0500
Received: from bay14-f21.bay14.hotmail.com ([64.4.49.21]:46598 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261273AbULAPTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:19:35 -0500
Message-ID: <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl>
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: intird.img file missing - cannot boot.
Date: Wed, 01 Dec 2004 17:18:22 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Dec 2004 15:19:05.0552 (UTC) FILETIME=[18A3B500:01C4D7B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had made some tests with mkinitrd , I deleted /boot/intird-2.6.7.img
and booted (without renaming the /boot/intird-2.6.7.img.old I have to 
intird-2.6.7.img).

I use this intird-2.6.7.img image in boot (ext3 is not part of the kernel 
image).
(I am working with Fedora with 2.6.7 , and with grub).

So when booting I get the mesages:
....
/intrd/intird-2.6.7.img
error 15: File Mot Fount
...

what should I do ? can I use a Fedora boot diskette and then
mount the boot partition and rename the file ? (the intird-2.6.7.img.old is 
, as
I said,under boot)
How can I do this mounting?
(If I remember well , a boot CD like KNPOIX does not have write 
permissions.)

Regards,
John

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

