Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVAFPMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVAFPMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVAFPK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:10:58 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:54407 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262859AbVAFPJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:09:02 -0500
From: "allen" <alee@ideeinc.com>
To: <linux-kernel@vger.kernel.org>
Subject: Diskless boot image
Date: Thu, 6 Jan 2005 10:08:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTzeFwPAJtLB1qvTuKunYve/3GDxAAiTZ7A
Message-Id: <20050106150853.ONVB25979.tomts25-srv.bellnexxia.net@allenxp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm building a diskless boot kernel, with kernel version 2.6.9 and
2.6.10-RC3. The client is able to connect to the server, and load the boot
image. However, whenever it reached encryption tests, the client machine
hangs at there. For different kernel version, it hangs at different
encryption tests. Does anyone know what's causing this problem?

For version 2.6.10-RC3, it hangs at the first test of sha384 cross page:


Testing sha384 cross page
test1:
(hangs at this point)

 

Thanks

Allen




