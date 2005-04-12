Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVDLPcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVDLPcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVDLPba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:31:30 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:33048 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262473AbVDLPaR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:30:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 10:30:19 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F122152@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/cjQ1+dPc57u5SNeG4sVe3YABjQAAEyaA
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>, <admin@list.net.ru>,
       <linux-kernel@vger.kernel.org>, "Wen Xiong" <wendyx@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wendy and I released under the GPL, and as such, I know legally you have
the right
to modify the code the way you see fit.

However, when the copyright holder says "No, please don't add that
code",
and gives *GOOD* reasons why, you should respect that decision.

So if I don't sign off on this change, does the matter?

If not, what good is having the sign off section for patches that must
go through the maintainer?

I would have no problem submitting the other driver (DGNC) for kernel
inclusion,
and have tried repeatedly in the past.

However, I am NOT willing to strip out many of the features our
customers,
(and as such, your USERS) want, which is what happened with the JSM
driver.

> There are people who just want the card supported.  There's no reason
> to deny the driver to them.

Oh, it *is* supported, using our GPL'ed DGNC driver available on our
ftp/web site.

This is not some argument of closed binaries versus open source
binaries,
As both the JSM and DGNC drivers are completely open source and GPL'ed.

This is about having the users of this card end up 
getting a worse experience by using the JSM driver.

However, in case it actually matters, (which I know it won't),

"I, Scott Kilau, *DO NOT* sign off on this patch to the JSM driver". 

Scott Kilau
Digi International
