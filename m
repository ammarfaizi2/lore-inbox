Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUIWLSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUIWLSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 07:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUIWLSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 07:18:50 -0400
Received: from magic.adaptec.com ([216.52.22.17]:31918 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S268405AbUIWLSH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 07:18:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: three days running fine, then memory allocation errors
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Thu, 23 Sep 2004 13:18:05 +0200
Message-ID: <B51CDBDEB98C094BB6E1985861F53AF31EE071@nkse2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: three days running fine, then memory allocation errors
Thread-Index: AcShW5xyT+c1RAeHQ6CHkDV/tHrq7QAA0jbw
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Ingo Freund" <Ingo.Freund@e-dict.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'm online and I will try to reproduce the error.

> -----Original Message-----
> From: Ingo Freund [mailto:Ingo.Freund@e-dict.net]
> Sent: Donnerstag, 23. September 2004 12:54
> To: Marcelo Tosatti
> Cc: linux-kernel@vger.kernel.org; Leubner, Achim
> Subject: RE: three days running fine, then memory allocation errors
> 
> Today the problem in requesting the controllers /proc entry came up
again.
> This time
> reboot   system boot  2.4.27           Tue Sep 21 10:35
(2+02:14)
> Sep 23 11:14:09 server01 kernel: __alloc_pages: 0-order allocation
failed (gfp=0x21/0)
> and still no output concerning memory usage of the controller.
> 
> Is Achim online?
> 
