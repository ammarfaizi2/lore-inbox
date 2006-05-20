Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWETEfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWETEfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWETEfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:35:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:63905 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751202AbWETEfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:35:41 -0400
Message-ID: <446E9C8F.60905@zytor.com>
Date: Fri, 19 May 2006 21:35:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Kbuild] Proper syntax for initramfs dependencies
Content-Type: multipart/mixed;
 boundary="------------070905090404070302030109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905090404070302030109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch adjusts the generation of initramfs dependencies, so that the 
syntax stays correct when there are multiple files.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------070905090404070302030109
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff"

ZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNoIGIvc2NyaXB0cy9n
ZW5faW5pdHJhbWZzX2xpc3Quc2gKaW5kZXggYjFlYmQ2NC4uMmFjOTQ5MCAxMDA2NDQKLS0t
IGEvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xpc3Quc2gKKysrIGIvc2NyaXB0cy9nZW5faW5p
dHJhbWZzX2xpc3Quc2gKQEAgLTE3OCw3ICsxNzgsNyBAQCBpbnB1dF9maWxlKCkgewogCQkJ
cHJpbnRfbXRpbWUgIiQxIiA+PiAke291dHB1dH0KIAkJCWNhdCAiJDEiICAgICAgICAgPj4g
JHtvdXRwdXR9CiAJCWVsc2UKLQkJCWdyZXAgXmZpbGUgIiQxIiB8IGN1dCAtZCAnICcgLWYg
MworCQkJZ3JlcCBeZmlsZSAiJDEiIHwgY3V0IC1kICcgJyAtZiAzIHwgc2VkIC1lICdzLyQv
IFxcLycKIAkJZmkKIAllbGlmIFsgLWQgIiQxIiBdOyB0aGVuCiAJCWRpcl9maWxlbGlzdCAi
JDEiCg==
--------------070905090404070302030109--
