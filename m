Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424589AbWKKR2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424589AbWKKR2C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 12:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424590AbWKKR2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 12:28:01 -0500
Received: from bay0-omc3-s10.bay0.hotmail.com ([65.54.246.210]:6564 "EHLO
	BAY0-OMC3-S10.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1424589AbWKKR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 12:28:00 -0500
Message-ID: <BAY20-F1295B62AC0FC28F560BA6BD8F60@phx.gbl>
X-Originating-IP: [80.178.105.247]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: trivial@kernel.org
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI remove unused variable and fix a compile time warning
Date: Sat, 11 Nov 2006 19:27:58 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_4d02_22a6_7b9b"
X-OriginalArrivalTime: 11 Nov 2006 17:28:00.0170 (UTC) FILETIME=[BC1F40A0:01C705B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_4d02_22a6_7b9b
Content-Type: text/plain; format=flowed

Hi.

This patch removes an unused variable and a warning that it generates.

Regards
Yan Burman

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

------=_NextPart_000_4d02_22a6_7b9b
Content-Type: application/octet-stream; name="acpi_events_remove_unsed.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi_events_remove_unsed.patch"

UmVtb3ZlIHVudXNlZCB2YXJpYWJsZSB0aGF0IGdlbmVyYXRlcyBhIGNvbXBp
bGUgdGltZSB3YXJuaW5nCgpTaWduZWQtb2ZmLWJ5OiBZYW4gQnVybWFuIDx5
YW5fOTUyQGhvdG1haWwuY29tPgoKLS0tIGxpbnV4LTIuNi4xOS1yYzVfb3Jp
Zy9kcml2ZXJzL2FjcGkvZXZlbnRzL2V2bWlzYy5jCTIwMDYtMTEtMDkgMTI6
MTY6MjEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTktcmM1L2Ry
aXZlcnMvYWNwaS9ldmVudHMvZXZtaXNjLmMJMjAwNi0xMS0xMSAwMDoxMToy
Mi4wMDAwMDAwMDAgKzAyMDAKQEAgLTMzMSw3ICszMzEsNiBAQCBzdGF0aWMg
dm9pZCBBQ1BJX1NZU1RFTV9YRkFDRSBhY3BpX2V2X2dsCiBzdGF0aWMgdTMy
IGFjcGlfZXZfZ2xvYmFsX2xvY2tfaGFuZGxlcih2b2lkICpjb250ZXh0KQog
ewogCXU4IGFjcXVpcmVkID0gRkFMU0U7Ci0JYWNwaV9zdGF0dXMgc3RhdHVz
OwogCiAJLyoKIAkgKiBBdHRlbXB0IHRvIGdldCB0aGUgbG9jawo=


------=_NextPart_000_4d02_22a6_7b9b--
