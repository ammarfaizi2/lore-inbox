Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUFYMPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUFYMPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUFYMPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:15:10 -0400
Received: from vmx15.multikabel.net ([212.127.254.144]:59329 "EHLO
	vmx15.multikabel.net") by vger.kernel.org with ESMTP
	id S265032AbUFYMPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:15:01 -0400
Subject: aes512 cryptoloop support -> gone?
From: Mitchel Sahertian <mitchel@sahertian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088165608.6399.20.camel@xinu.sahe.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 14:13:29 +0200
Content-Transfer-Encoding: 7bit
X-MultiKabel-MailScanner-Information: Please contact helpdesk@quicknet.nl for more information
X-MultiKabel-MailScanner: Found to be clean
X-MultiKabel-MailScanner-SpamCheck: 
X-MultiKabel-MX-MailScanner-Information: Please contact helpdesk@quicknet.nl for more information
X-MultiKabel-MX-MailScanner: Found to be clean
X-MultiKabel-MX-MailScanner-SpamCheck: 
X-MailScanner-From: mitchel@sahertian.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With some 2.4.x kernel i created a crypto loopback with an aes512
cipher. Afair i was able to use it with 2.5.x too. But at some moment
512bit support was removed and as of now, 256 is the max. I guess
support was removed for legal reasons or so..

Are there any patches for 2.6/aesloop/cryptoloop or "tools" to read or
convert my loopback device?

