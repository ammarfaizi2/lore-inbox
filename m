Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVAEXUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVAEXUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVAEXUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:20:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:12524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262656AbVAEXSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:18:31 -0500
Date: Wed, 5 Jan 2005 15:18:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Willem Riede <osst@riede.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] osst upgrade to 0.99.3
Message-Id: <20050105151819.1a4981ae.akpm@osdl.org>
In-Reply-To: <1104627552l.3427l.2l@serve.riede.org>
References: <1104627552l.3427l.2l@serve.riede.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede <osst@riede.org> wrote:
>
> In a series of three mails, I'll present changes I'd like to see 
>  made to the osst driver in the linux-2.6.11 pre-series.

All three patches were hopelessly mangled by your email client:

70 out of 70 hunks FAILED -- saving rejects to file drivers/scsi/osst.c.rej
osst-style-changes does not apply

Please sort out your email client and send the patches to yourself to test
that they still apply.

When resending please ensure that the patch headers are in `-p1' form:

--- osst-patches/osst.h	2005-01-01 19:15:32.700230984 -0500
+++ /home/wriede/SfOsstCVS/Driver26/osst.h	2005-01-01 16:13:35.000000000 -0500

Things like the above will not apply to anyone's tree without jumping
through hoops.

Also, please don't send multiple patches under the same Subject:.

See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.
