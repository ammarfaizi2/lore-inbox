Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWARE6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWARE6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWARE6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:58:08 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:17520 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030183AbWARE6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:58:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=qOdSNl3NnXVYr603Pe4e/vPFH9h8416ttuVc7HJKq3dffag0YWP3RhWOzpPLIEd1a38smeBHN2FMCUSmbN2AnNHZAX0f29ZcCYchqco5kt+4oWHTr9coDGBsFpYf+Ae0UCeLfHUpqxU/TBBUQfBzj5mNSasLnzj/pKWdwUl+Du4=
Message-ID: <cc723f590601172058n67fb2200ybfffba9bc4fc72ba@mail.gmail.com>
Date: Wed, 18 Jan 2006 10:28:06 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Add entry.S function name to tag file
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16100_17109266.1137560286359"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16100_17109266.1137560286359
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

How about a patch like the one attached below. I am not sure whether i
got the regular expression correct. But it works for me.

-aneesh

------=_Part_16100_17109266.1137560286359
Content-Type: text/x-patch; name="Makefile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile.diff"

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggMjUyYTY1OS4uNmM4NDc5ZSAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTEyNzIsNyArMTI3Miw3IEBA
IGRlZmluZSBjbWRfdGFncwogCUNUQUdTRj1gY3RhZ3MgLS12ZXJzaW9uIHwgZ3JlcCAtaSBleHVi
ZXJhbnQgPi9kZXYvbnVsbCAmJiAgICAgXAogICAgICAgICAgICAgICAgIGVjaG8gIi1JIF9faW5p
dGRhdGEsX19leGl0ZGF0YSxfX2FjcXVpcmVzLF9fcmVsZWFzZXMgIFwKICAgICAgICAgICAgICAg
ICAgICAgICAtSSBFWFBPUlRfU1lNQk9MLEVYUE9SVF9TWU1CT0xfR1BMICAgICAgICAgICAgICBc
Ci0gICAgICAgICAgICAgICAgICAgICAgLS1leHRyYT0rZiAtLWMta2luZHM9K3B4ImA7ICAgICAg
ICAgICAgICAgICAgICAgXAorICAgICAgICAgICAgICAgICAgICAgIC0tZXh0cmE9K2YgLS1jLWtp
bmRzPStweCAtLXJlZ2V4LWFzbT0vRU5UUllcKChbXildKilcKS4qL1wxL2YvImA7ICBcCiAgICAg
ICAgICAgICAgICAgJChhbGwtc291cmNlcykgfCB4YXJncyBjdGFncyAkJENUQUdTRiAtYQogZW5k
ZWYKIAo=
------=_Part_16100_17109266.1137560286359--
