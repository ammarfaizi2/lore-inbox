Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUCNWBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUCNWBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:01:02 -0500
Received: from colino.net ([62.212.100.143]:18415 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261821AbUCNWBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:01:00 -0500
Date: Sun, 14 Mar 2004 22:59:13 +0100
From: Colin Leroy <colin@colino.net>
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.4-bk3 ppc32 compile fix
Message-Id: <20040314225913.4654347b@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__14_Mar_2004_22_59_13_+0100_NT5NfBGMQKnKbhpL"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__14_Mar_2004_22_59_13_+0100_NT5NfBGMQKnKbhpL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, 

2.6.4-bk3 (ie, 2.6.4 + bk3 patch at kernel.org) does not compile without this patch.

HTH,
-- 
Colin

--Multipart=_Sun__14_Mar_2004_22_59_13_+0100_NT5NfBGMQKnKbhpL
Content-Type: application/octet-stream;
 name="2.6.4-bk3.compile.fix"
Content-Disposition: attachment;
 filename="2.6.4-bk3.compile.fix"
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvYXNtLXBwYy91bmlzdGQuaC5vbGQJMjAwNC0wMy0xNCAyMjo1Njo0Mi45MDEx
MDU3ODQgKzAxMDAKKysrIGluY2x1ZGUvYXNtLXBwYy91bmlzdGQuaAkyMDA0LTAzLTE0IDIyOjU2
OjQ1LjI3Njc0NDYzMiArMDEwMApAQCAtMzgwLDYgKzM4MCw3IEBACiAKICNpbmNsdWRlIDxsaW51
eC9jb21waWxlci5oPgogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5jbHVkZSA8bGludXgv
bGlua2FnZS5oPgogCiAvKgogICogU3lzdGVtIGNhbGwgcHJvdG90eXBlcy4K

--Multipart=_Sun__14_Mar_2004_22_59_13_+0100_NT5NfBGMQKnKbhpL--
