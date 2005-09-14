Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbVINM74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVINM74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVINM74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:59:56 -0400
Received: from [139.30.44.16] ([139.30.44.16]:27266 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S965169AbVINM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:59:55 -0400
Date: Wed, 14 Sep 2005 14:59:08 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, shemminger@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: SKGE Kconfig help text typo fix
In-Reply-To: <432819E2.6010506@pobox.com>
Message-ID: <Pine.LNX.4.53.0509141455130.7058@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0509081102500.19683@gans.physik3.uni-rostock.de>
 <432819E2.6010506@pobox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="512430124-636400625-1126702748=:7058"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--512430124-636400625-1126702748=:7058
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 14 Sep 2005, Jeff Garzik wrote:

> Tim Schmielau wrote:
> > SKGE surely isn't a meta driver. Not that this is relevant at all...
> >
> > Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
>
> patch doesn't apply, please resend

Here it is, rediffed against latest netdev-2.6 git tree on kernel.org.
However, it differs from the previous one only in the offset, so I've
attached it to rule out mangling by the mailer.

Please holler if it still does not apply.

Tim
--512430124-636400625-1126702748=:7058
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kconfig-skge.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0509141459080.7058@gockel.physik3.uni-rostock.de>
Content-Description: 
Content-Disposition: attachment; filename="kconfig-skge.patch"

LS0tIGxpbnV4LTIuNi4xMy1uZXRkZXYvZHJpdmVycy9uZXQvS2NvbmZpZwky
MDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4
LTIuNi4xMy1uZXRkZXYtc2tnZS9kcml2ZXJzL25ldC9LY29uZmlnCTIwMDUt
MDktMDggMTA6NTc6MzguMDAwMDAwMDAwICswMjAwDQpAQCAtMTk0NCw3ICsx
OTQ0LDcgQEAgY29uZmlnIFNLR0UNCiAJLS0taGVscC0tLQ0KIAkgIFRoaXMg
ZHJpdmVyIHN1cHBvcnQgdGhlIE1hcnZlbGwgWXVrb24gb3IgU3lzS29ubmVj
dCBTSy05OHh4L1NLLTk1eHgNCiAJICBhbmQgcmVsYXRlZCBHaWdhYml0IEV0
aGVybmV0IGFkYXB0ZXJzLiBJdCBpcyBhIG5ldyBzbWFsbGVyIGRyaXZlcg0K
LQkgIGRyaXZlciB3aXRoIGJldHRlciBwZXJmb3JtYW5jZSBhbmQgbW9yZSBj
b21wbGV0ZSBldGh0b29sIHN1cHBvcnQuDQorCSAgd2l0aCBiZXR0ZXIgcGVy
Zm9ybWFuY2UgYW5kIG1vcmUgY29tcGxldGUgZXRodG9vbCBzdXBwb3J0Lg0K
IA0KIAkgIEl0IGRvZXMgbm90IHN1cHBvcnQgdGhlIGxpbmsgZmFpbG92ZXIg
YW5kIG5ldHdvcmsgbWFuYWdlbWVudCANCiAJICBmZWF0dXJlcyB0aGF0ICJw
b3J0YWJsZSIgdmVuZG9yIHN1cHBsaWVkIHNrOThsaW4gZHJpdmVyIGRvZXMu
DQo=

--512430124-636400625-1126702748=:7058--
