Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVEaKva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVEaKva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVEaKva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:51:30 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:2485 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261783AbVEaKvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:51:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=NO0cJDljvtdS0PidL6jidhxjdYEMNua8JLb6x6+SeS1l6I1A5s4b8tviGcPZRMQxUcCBztr4r1xy3SALOtdIdfWtDDfLY4IGi0OG48WhPTbUiUzYpGo3GimP5i/vjRBHUktakYUXviQxdchrdj458MS3JSPFC8f+ARSwjpYIoJU=
Message-ID: <81083a45050531035111ddc289@mail.gmail.com>
Date: Tue, 31 May 2005 16:21:18 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
Reply-To: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fixes the warnings obtained with arm-elf-gcc 3.4
In-Reply-To: <81083a450505310337131c3e31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19390_14265308.1117536678536"
References: <81083a450505310337131c3e31@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_19390_14265308.1117536678536
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch fixes the warnings obtained with arm-elf-gcc 3.4.

Files Affected -

-fs/jffs2/read.c
-fs/jffs2/nodemgmt.c
-fs/jffs2/readinode.c
-fs/jffs2/write.c
-fs/jffs2/gc.c
-fs/jffs2/erase.c
-fs/nfs/nfs2xdr.c
-fs/nfs/nfs3xdr.c
-drivers/base/dmapool.c
-drivers/char/random.c
-drivers/serial/8250_early.c
-net/core/dev.c
-net/sunrpc/xprt.c
-net/sunrpc/svc.c
-net/sunrpv/svcsock.c

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_19390_14265308.1117536678536
Content-Type: text/plain; name="pat.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pat.txt"


------=_Part_19390_14265308.1117536678536--
