Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUITK7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUITK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUITK7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:59:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:35233 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266223AbUITK6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:58:40 -0400
Date: Mon, 20 Sep 2004 12:58:39 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: device@lanana.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary211621095677919"
Subject: [PATCH] (2.6.9-rc2) MAINTAINERS - lanana.org web server address
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <21162.1095677919@www37.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary211621095677919
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes the web server address for lanana.org
in the MAINTAINERS file of linux kernel 2.6.9-rc2.

The problem was that the needed "www." prefix was missing.
In this case lanana does not respont when the prefix is left out.
I know some browsers are doing autoprobping with a few prefixes,
but i know and do use at least three browsers that dont do that.
These are: mozilla 1.6, lynx 2.8.5rel.2 and recent opera for windows.

please apply.

-Alex.

-- 
Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl
--========GMXBoundary211621095677919
Content-Type: application/octet-stream; name="linux-2.6.9-rc2-maintainers.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.9-rc2-maintainers.diff"

ZGlmZiAtTnJ1IGxpbnV4LTIuNi45LXJjMi5vcmlnLW1haW50YWluZXJzL01BSU5UQUlORVJTIGxp
bnV4LTIuNi45LXJjMi9NQUlOVEFJTkVSUwotLS0gbGludXgtMi42LjktcmMyLm9yaWctbWFpbnRh
aW5lcnMvTUFJTlRBSU5FUlMJMjAwNC0wOS0xMyAwNzozMjo1NC4wMDAwMDAwMDAgKzAyMDAKKysr
IGxpbnV4LTIuNi45LXJjMi9NQUlOVEFJTkVSUwkyMDA0LTA5LTIwIDEyOjQ3OjQxLjAwMDAwMDAw
MCArMDIwMApAQCAtNjU4LDcgKzY1OCw3IEBACiBERVZJQ0UgTlVNQkVSIFJFR0lTVFJZCiBQOglU
b3JiZW4gTWF0aGlhc2VuCiBNOglkZXZpY2VAbGFuYW5hLm9yZwotVzoJaHR0cDovL2xhbmFuYS5v
cmcvZG9jcy9kZXZpY2UtbGlzdC9pbmRleC5odG1sCitXOglodHRwOi8vd3d3LmxhbmFuYS5vcmcv
ZG9jcy9kZXZpY2UtbGlzdC9pbmRleC5odG1sCiBMOglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCiBTOglNYWludGFpbmVkCiAK

--========GMXBoundary211621095677919--

