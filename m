Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWFSN6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWFSN6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWFSN6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:58:43 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:23681 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932273AbWFSN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:58:43 -0400
Date: Mon, 19 Jun 2006 15:58:24 +0200
From: Voluspa <lista1@comhem.se>
To: 69rydzyk69@gmail.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, be-news06@lina.inka.de,
       jengelh@linux01.gwdg.de
Subject: Re: Several errors in kernel
Message-Id: <20060619155824.7cc1ad6c.lista1@comhem.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The nsxfeval is completely harmless and has been fixed in the
"ACPI: Subsystem revision 20060310" present in -mm kernels.

The "Failed to allocate mem resource" is also harmless but Greg KH
has decided to not hide/fix it. Our BIOS vendors are to blame.

For a summary see:
[Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
hackers.]
http://marc.theaimsgroup.com/?l=linux-kernel&m=113957514307078&w=2

I started the thread at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113952620328363&w=2

Mvh
Mats Johannesson
--
