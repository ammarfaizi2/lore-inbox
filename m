Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVKHMxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVKHMxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVKHMxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:53:45 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7475
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965049AbVKHMxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:53:45 -0500
Message-Id: <4370AE20.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 13:54:40 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor ELF addition
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFBD9C500.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFBD9C500.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A trivial addition to the ELF definitions.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)

--=__PartFBD9C500.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-elf.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-elf.patch"

QSB0cml2aWFsIGFkZGl0aW9uIHRvIHRoZSBFTEYgZGVmaW5pdGlvbnMuCgpGcm9tOiBKYW4gQmV1
bGljaCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCi0tLSAyLjYuMTQvaW5jbHVkZS9saW51eC9lbGYu
aAkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LWVsZi9pbmNs
dWRlL2xpbnV4L2VsZi5oCTIwMDUtMTEtMDQgMTY6MTk6MzQuMDAwMDAwMDAwICswMTAwCkBAIC0x
NTEsNiArMTUxLDggQEAgdHlwZWRlZiBfX3M2NAlFbGY2NF9TeHdvcmQ7CiAjZGVmaW5lIFNUVF9G
VU5DICAgIDIKICNkZWZpbmUgU1RUX1NFQ1RJT04gMwogI2RlZmluZSBTVFRfRklMRSAgICA0Cisj
ZGVmaW5lIFNUVF9DT01NT04gIDUKKyNkZWZpbmUgU1RUX1RMUyAgICAgNgogCiAjZGVmaW5lIEVM
Rl9TVF9CSU5EKHgpCQkoKHgpID4+IDQpCiAjZGVmaW5lIEVMRl9TVF9UWVBFKHgpCQkoKCh1bnNp
Z25lZCBpbnQpIHgpICYgMHhmKQo=

--=__PartFBD9C500.0__=--
