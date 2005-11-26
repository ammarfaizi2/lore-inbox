Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKZUeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKZUeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVKZUeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:34:19 -0500
Received: from mail.telvia.it ([213.155.209.57]:34569 "EHLO efesto.telvia.it")
	by vger.kernel.org with ESMTP id S1750737AbVKZUeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:34:19 -0500
Date: Sat, 26 Nov 2005 20:33:30 +0000
From: asbesto <asbesto@freaknet.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.6.1x "make" fail (solved, please read)
Message-ID: <20051126203330.GA31006@freaknet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Useless-Header: Non usare le lettere accentate.
X-GPG-Fingerprint: 8935 5586 7F2D 9C5E 51B6  BBC5 EA15 9A4E 613D 44D7
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

using the character > ' < in the

() Local version - append to kernel release

will cause "make" to fail. Here's an example:

Using:
(Gesu'Cristo) Local version - append to kernel release 

will cause:
gemini linux # make
/bin/sh: -c: line 0: unexpected EOF while looking for matching"'
/bin/sh: -c: line 1: syntax error: unexpected end of file
make: *** [include/linux/version.h] Error 2 

hope this help!


-- 
[ asbesto : IW9HGS : freaknet medialab : radiocybernet : poetry ]
[ http://freaknet.org/asbesto http://papuasia.org/radiocybernet ]
[ http://www.emergelab.org :: NON SCRIVERMI USANDO LE ACCENTATE ]
[ *I DELETE* EMAIL > 100K, ATTACHMENTS, HTML, M$-WORD DOC, SPAM ]

