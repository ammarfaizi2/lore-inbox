Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbULLPSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbULLPSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbULLPSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 10:18:31 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:42162 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262081AbULLPS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 10:18:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=j+j0GxRAVqxw0qRMYE3fSAB7I9NdxlcobmNtKWkh7Am6PolQ2R+fLObCohJJ9zd4GcK0F/H8i+cdZXhzVtmYkED5qc6FheBGp7WeT6AHJJftkk+aWpORJ9toNsn9T0akpaXcFwTZPsIiTT9v90ys6T5pmrlDC6v0CqbEeL/u8D0=
Message-ID: <aec7e5c3041212071828d36f00@mail.gmail.com>
Date: Sun, 12 Dec 2004 16:18:26 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aty128fb: MODULE_PARM_DESC
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_670_14377387.1102864706884"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_670_14377387.1102864706884
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Heya,

Wrong parameter names are used with MODULE_PARM_DESC in aty128fb.

/ magnus

------=_Part_670_14377387.1102864706884
Content-Type: application/octet-stream; name="linux-2.6.10-rc3-aty128fb_parm_desc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.10-rc3-aty128fb_parm_desc.patch"

LS0tIGxpbnV4LTIuNi4xMC1yYzMvZHJpdmVycy92aWRlby9hdHkvYXR5MTI4ZmIuYwkyMDA0LTEy
LTAzIDE1OjAwOjU0LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjEwLXJjMy1hdHkxMjhm
Yl9wYXJtX2Rlc2MvZHJpdmVycy92aWRlby9hdHkvYXR5MTI4ZmIuYwkyMDA0LTEyLTEyIDE1OjU2
OjQ5LjgxNzk2MTYwMCArMDEwMApAQCAtMjQ2NCwxMCArMjQ2NCwxMCBAQAogTU9EVUxFX0RFU0NS
SVBUSU9OKCJGQkRldiBkcml2ZXIgZm9yIEFUSSBSYWdlMTI4IC8gUHJvIGNhcmRzIik7CiBNT0RV
TEVfTElDRU5TRSgiR1BMIik7CiBtb2R1bGVfcGFyYW0obW9kZV9vcHRpb24sIGNoYXJwLCAwKTsK
LU1PRFVMRV9QQVJNX0RFU0MobW9kZSwgIlNwZWNpZnkgcmVzb2x1dGlvbiBhcyBcIjx4cmVzPng8
eXJlcz5bLTxicHA+XVtAPHJlZnJlc2g+XVwiICIpOworTU9EVUxFX1BBUk1fREVTQyhtb2RlX29w
dGlvbiwgIlNwZWNpZnkgcmVzb2x1dGlvbiBhcyBcIjx4cmVzPng8eXJlcz5bLTxicHA+XVtAPHJl
ZnJlc2g+XVwiICIpOwogI2lmZGVmIENPTkZJR19NVFJSCiBtb2R1bGVfcGFyYW1fbmFtZWQobm9t
dHJyLCBtdHJyLCBpbnZib29sLCAwKTsKLU1PRFVMRV9QQVJNX0RFU0MobXRyciwgImJvb2w6IERp
c2FibGUgTVRSUiBzdXBwb3J0ICgwIG9yIDE9ZGlzYWJsZWQpIChkZWZhdWx0PTApIik7CitNT0RV
TEVfUEFSTV9ERVNDKG5vbXRyciwgImJvb2w6IERpc2FibGUgTVRSUiBzdXBwb3J0ICgwIG9yIDE9
ZGlzYWJsZWQpIChkZWZhdWx0PTApIik7CiAjZW5kaWYKICNlbmRpZgogCg==
------=_Part_670_14377387.1102864706884--
