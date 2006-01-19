Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWASG2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWASG2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWASG2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:28:35 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:51603 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932564AbWASG2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:28:35 -0500
Message-ID: <43CF31E8.9030705@keyaccess.nl>
Date: Thu, 19 Jan 2006 07:30:00 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adam Belay <ambx1@neo.rr.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]  PnPBIOS: Missing SMALL_TAG_ENDDEP tag
Content-Type: multipart/mixed;
 boundary="------------050707070202050109090301"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707070202050109090301
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Sorry, second copy, forgot to CC LKML.

Without the attached, the kernel complains about my BIOS' PNP tables. It
was ACKed before, but never merged:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110237794007900&w=2

Rene.


--------------050707070202050109090301
Content-Type: text/plain;
 name="rsparser.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="rsparser.diff"

SW5kZXg6IGxvY2FsL2RyaXZlcnMvcG5wL3BucGJpb3MvcnNwYXJzZXIuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsb2NhbC5vcmlnL2RyaXZlcnMvcG5wL3BucGJpb3MvcnNwYXJzZXIuYwkyMDA2
LTAxLTAzIDA0OjIxOjEwLjAwMDAwMDAwMCArMDEwMAorKysgbG9jYWwvZHJpdmVycy9wbnAv
cG5wYmlvcy9yc3BhcnNlci5jCTIwMDYtMDEtMTggMDk6NDE6MDcuMDAwMDAwMDAwICswMTAw
CkBAIC00NDgsMTEgKzQ0OCw3IEBAIHBucGJpb3NfcGFyc2VfcmVzb3VyY2Vfb3B0aW9uX2Rh
dGEodW5zaWcKIAkJCWJyZWFrOwogCiAJCWNhc2UgU01BTExfVEFHX0VORDoKLQkJCWlmIChv
cHRpb25faW5kZXBlbmRlbnQgIT0gb3B0aW9uKQotCQkJCXByaW50ayhLRVJOX1dBUk5JTkcg
IlBuUEJJT1M6IE1pc3NpbmcgU01BTExfVEFHX0VORERFUCB0YWdcbiIpOwotCQkJcCA9IHAg
KyAyOwotICAgICAgICAJCXJldHVybiAodW5zaWduZWQgY2hhciAqKXA7Ci0JCQlicmVhazsK
KyAgICAgICAgCQlyZXR1cm4gcCArIDI7CiAKIAkJZGVmYXVsdDogLyogYW4gdW5rb3duIHRh
ZyAqLwogCQkJbGVuX2VycjoK
--------------050707070202050109090301--
