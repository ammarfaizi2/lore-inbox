Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVKHOVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVKHOVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVKHOVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:21:11 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:5702
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965216AbVKHOVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:21:09 -0500
Message-Id: <4370C29C.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:22:04 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: remove dead die_if_kernel()
References: <4370AFF0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part73514D9C.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part73514D9C.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Removing unused function die_if_kernel().

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part73514D9C.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-die-if-kernel.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-die-if-kernel.patch"

UmVtb3ZpbmcgdW51c2VkIGZ1bmN0aW9uIGRpZV9pZl9rZXJuZWwoKS4KCkZyb206IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIDIuNi4xNC9hcmNoL3g4Nl82NC9rZXJuZWwv
dHJhcHMuYwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LXg4
Nl82NC1kaWUtaWYta2VybmVsL2FyY2gveDg2XzY0L2tlcm5lbC90cmFwcy5jCTIwMDUtMTEtMDcg
MDk6MzM6NTMuMDAwMDAwMDAwICswMTAwCkBAIC0zOTksMTEgKzM5OSw2IEBAIHZvaWQgZGllKGNv
bnN0IGNoYXIgKiBzdHIsIHN0cnVjdCBwdF9yZWcKIAlvb3BzX2VuZChmbGFncyk7CiAJZG9fZXhp
dChTSUdTRUdWKTsgCiB9Ci1zdGF0aWMgaW5saW5lIHZvaWQgZGllX2lmX2tlcm5lbChjb25zdCBj
aGFyICogc3RyLCBzdHJ1Y3QgcHRfcmVncyAqIHJlZ3MsIGxvbmcgZXJyKQotewotCWlmICghKHJl
Z3MtPmVmbGFncyAmIFZNX01BU0spICYmIChyZWdzLT5jcyA9PSBfX0tFUk5FTF9DUykpCi0JCWRp
ZShzdHIsIHJlZ3MsIGVycik7Ci19CiAKIHZvaWQgZGllX25taShjaGFyICpzdHIsIHN0cnVjdCBw
dF9yZWdzICpyZWdzKQogewo=

--=__Part73514D9C.1__=--
