Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTIJMle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTIJMle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:41:34 -0400
Received: from gate.firmix.at ([80.109.18.208]:46209 "EHLO tara.firmix.at")
	by vger.kernel.org with ESMTP id S262905AbTIJMlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:41:31 -0400
Subject: [PATCH] Remove warning in 2.6.0-test5/mm/memory.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ERlXD/vUFu9WFEACSNYU"
Message-Id: <1063197687.4960.36.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 14:41:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ERlXD/vUFu9WFEACSNYU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all!

The attached patch removes a warning in 2.6.0-test5/mm/memory.c
if CONFIG_SWAP is disabled.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--=-ERlXD/vUFu9WFEACSNYU
Content-Disposition: attachment; filename=memory.c-patch
Content-Type: text/plain; name=memory.c-patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4wLXRlc3Q1L21tL21lbW9yeS5jCTIwMDMtMDktMTAgMTQ6Mjg6MjEuMDAw
MDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjAtdGVzdDUtb3JpZy9tbS9tZW1vcnkuYwkyMDAz
LTA5LTA4IDIxOjUwOjAzLjAwMDAwMDAwMCArMDIwMA0KQEAgLTEyNzMsNyArMTI3Myw3IEBADQog
CQkNCiAJc3dhcF9mcmVlKGVudHJ5KTsNCiAJaWYgKHZtX3N3YXBfZnVsbCgpKQ0KLQkJKHZvaWQp
cmVtb3ZlX2V4Y2x1c2l2ZV9zd2FwX3BhZ2UocGFnZSk7DQorCQlyZW1vdmVfZXhjbHVzaXZlX3N3
YXBfcGFnZShwYWdlKTsNCiANCiAJbW0tPnJzcysrOw0KIAlwdGUgPSBta19wdGUocGFnZSwgdm1h
LT52bV9wYWdlX3Byb3QpOw0K

--=-ERlXD/vUFu9WFEACSNYU--
