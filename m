Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUALO6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUALO6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:58:43 -0500
Received: from mail.alu.ua.es ([193.145.233.9]:35257 "EHLO mail.alu.ua.es")
	by vger.kernel.org with ESMTP id S265560AbUALO6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:58:41 -0500
Subject: [PATCH] ACPI dispatcher, kernel 2.6.1
From: Daniel Micol Ponce <dmp18@alu.ua.es>
Reply-To: daniel.micol@unix.net
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-DWBk6eQcEznkpjybuXAR"
Message-Id: <1073919520.5457.8.camel@DMICOL.MICOLPONCE>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 15:58:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DWBk6eQcEznkpjybuXAR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've found a non-sense line of code in
drivers/acpi/dispatcher/dsmthdat.c that does nothing and gives a warning
when compiling. Here I attach the diff file and a README.

Daniel Micol

--=-DWBk6eQcEznkpjybuXAR
Content-Disposition: attachment; filename=patch.diff.gz
Content-Type: application/x-gzip; name=patch.diff.gz
Content-Transfer-Encoding: base64

H4sICLsH/z8AA3BhdGNoLmRpZmYAfVDLboMwEDzDV+ypCgJjmxASiBoRVa0UqYeqSc4WNY5CGx6y
TdOqyr/XkNDHobUP3tXOzI4HIQS4VRIryfGhqNo3nMviVUiFM94UOC9Uk2m+FxLnqtT7PNM+twJC
QkQoIjEEJKFRMg59MhxwCSXEdl0X/qRMooRO/VlI4iCkYXihpCmgiFBvCm73RJCmNliVOLL66Znl
QnG4hqGcm1Gxg9HQowWvy7KufCl2QoqKC8brttKwAOrAh0FbSme6VUaj+xprtQE076wwCoJrpuuh
/Bb14Orneg+O2eGFdTrCmdvI+mWuc9RbWt48rNjdcnW/fbyF0Xmrc/FgSaFbWbEes94sN9v1F6QX
OJ1jiIk3MTHMYm/cx2BG/zNPNjL3EwgEl9nQAQAA

--=-DWBk6eQcEznkpjybuXAR
Content-Disposition: attachment; filename=README
Content-Type: text/x-readme; name=README; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Daniel Micol Ponce <dmp18@alu.ua.es> [ACPI] Removed a non-sense line of code that returned a warning when compiling

--=-DWBk6eQcEznkpjybuXAR--

