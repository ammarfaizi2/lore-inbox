Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131011AbRCJLbQ>; Sat, 10 Mar 2001 06:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131012AbRCJLbG>; Sat, 10 Mar 2001 06:31:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131011AbRCJLaz>; Sat, 10 Mar 2001 06:30:55 -0500
Subject: Re: a bug report for 2.4.2 kernel
To: shih215@home.com (root)
Date: Sat, 10 Mar 2001 11:33:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA8610D.2675B47F@home.com> from "root" at Mar 08, 2001 11:50:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bhcs-0006hR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ude/linux/modversions.h   -c -o iriap.o iriap.c
> iriap.c: In function `iriap_getvaluebyclass_request_R87307dbc':
> iriap.c:425: Internal error: Segmentation fault.
> Please submit a full bug report.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.


What version of gcc are you using  - 2.96-54 ?
