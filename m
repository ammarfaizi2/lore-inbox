Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUDJGKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUDJGKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 02:10:44 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:28585 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S261939AbUDJGKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 02:10:43 -0400
Date: Sat, 10 Apr 2004 10:11:35 +0400
From: Kirill Korotaev <kirillx@7ka.mipt.ru>
Reply-To: Kirill Korotaev <kirillx@7ka.mipt.ru>
Organization: SWsoft
X-Priority: 3 (Normal)
Message-ID: <8110174006.20040410101135@7ka.mipt.ru>
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] memory access to free memory in 2.4.x
In-Reply-To: <403331971.20040410095137@7ka.mipt.ru>
References: <403331971.20040410095137@7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------CC6523025296CA6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------CC6523025296CA6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

memory access to files which are already put.

Kirill

------------CC6523025296CA6
Content-Type: application/octet-stream; name="proc-putfiles.diff"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="proc-putfiles.diff"

LS0tIGxpbnV4LTIuNC4yMC9mcy9wcm9jL2Jhc2UuYy5zYXZlZAlTYXQgQXByICA1IDEzOjU3
OjQ1IDIwMDMKKysrIGxpbnV4LTIuNC4yMC9mcy9wcm9jL2Jhc2UuYwlTYXQgQXByICA1IDEz
OjU4OjAzIDIwMDMKQEAgLTgyNSw4ICs4MjUsOCBAQAogCXJldHVybiBOVUxMOwogCiBvdXRf
dW5sb2NrMjoKLQlwdXRfZmlsZXNfc3RydWN0KGZpbGVzKTsKIAlyZWFkX3VubG9jaygmZmls
ZXMtPmZpbGVfbG9jayk7CisJcHV0X2ZpbGVzX3N0cnVjdChmaWxlcyk7CiBvdXRfdW5sb2Nr
OgogCWlwdXQoaW5vZGUpOwogb3V0Ogo=
------------CC6523025296CA6--

