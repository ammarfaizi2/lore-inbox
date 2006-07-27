Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWG0NRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWG0NRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWG0NRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:17:07 -0400
Received: from mail.ccur.com ([66.10.65.12]:22888 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1161061AbWG0NRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:17:06 -0400
Subject: patch for Documentation/initrd.txt?
From: Tom Horsley <tom.horsley@ccur.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bugsy <bugsy@ccur.com>
Content-Type: multipart/mixed; boundary="=-qxqpMI/pBpHdC+9/sPku"
Date: Thu, 27 Jul 2006 09:17:04 -0400
Message-Id: <1154006224.5166.4.camel@tweety>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qxqpMI/pBpHdC+9/sPku
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I spend hours the other day trying to examine a fedora core 5
initrd file in the mistaken belief that the Documentation/initrd.txt
file might contain relevant information :-). It didn't, but
many web searches later I finally discovered the new key
to decrypting initrd files. Would it be possible to add the
attached patch (or a better one if someone can explain things
in more detail) to the initrd.txt file to avoid future
confusion? Thanks.

--=-qxqpMI/pBpHdC+9/sPku
Content-Disposition: attachment; filename=initrd-doc-patch
Content-Type: text/plain; name=initrd-doc-patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xNy43L0RvY3VtZW50YXRpb24vaW5pdHJkLnR4dAkyMDA2LTA3LTI3IDA4
OjQ5OjMwLjAwMDAwMDAwMCAtMDQwMA0KKysrIGxpbnV4LTIuNi4xNy43L0RvY3VtZW50YXRpb24v
aW5pdHJkLnR4dAkyMDA2LTA3LTI3IDA5OjAyOjA0LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTczLDYg
KzczLDIyIEBADQogICAgIGluaXRyZCBpcyBtb3VudGVkIGFzIHJvb3QsIGFuZCB0aGUgbm9ybWFs
IGJvb3QgcHJvY2VkdXJlIGlzIGZvbGxvd2VkLA0KICAgICB3aXRoIHRoZSBSQU0gZGlzayBzdGls
bCBtb3VudGVkIGFzIHJvb3QuDQogDQorQ29tcHJlc3NlZCBjcGlvIGltYWdlcw0KKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCisNCitSZWNlbnQga2VybmVscyBoYXZlIHN1cHBvcnQgZm9yIHBvcHVs
YXRpbmcgYSByYW1kaXNrIGZyb20gYSBjb21wcmVzc2VkIGNwaW8NCithcmNoaXZlLCBvbiBzdWNo
IHN5c3RlbXMsIHRoZSBjcmVhdGlvbiBvZiBhIHJhbWRpc2sgaW1hZ2UgZG9lc24ndCBuZWVkIHRv
DQoraW52b2x2ZSBzcGVjaWFsIGJsb2NrIGRldmljZXMgb3IgbG9vcGJhY2tzLCB5b3UgbWVyZWx5
IGNyZWF0ZSBhIGRpcmVjdG9yeSBvbg0KK2Rpc2sgd2l0aCB0aGUgZGVzaXJlZCBpbml0cmQgY29u
dGVudCwgY2QgdG8gdGhhdCBkaXJlY3RvcnksIGFuZCBydW4gKGFzIGFuDQorZXhhbXBsZSk6DQor
DQorZmluZCAuIHwgY3BpbyAtLXF1aWV0IC1jIC1vIHwgZ3ppcCAtOSAtbiA+IC9ib290L2ltYWdl
ZmlsZS5pbWcNCisNCitFeGFtaW5pbmcgdGhlIGNvbnRlbnRzIG9mIGFuIGV4aXN0aW5nIGltYWdl
IGZpbGUgaXMganVzdCBhcyBzaW1wbGU6DQorDQorbWtkaXIgL3RtcC9pbWFnZWZpbGUNCitjZCAv
dG1wL2ltYWdlZmlsZQ0KK2d6aXAgLWNkIC9ib290L2ltYWdlZmlsZS5pbWcgfCBjcGlvIC1pbWQg
LS1xdWlldA0KIA0KIEluc3RhbGxhdGlvbg0KIC0tLS0tLS0tLS0tLQ0K


--=-qxqpMI/pBpHdC+9/sPku--
