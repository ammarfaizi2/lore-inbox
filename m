Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130832AbRCFBxt>; Mon, 5 Mar 2001 20:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130833AbRCFBxj>; Mon, 5 Mar 2001 20:53:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:263 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130832AbRCFBxg>; Mon, 5 Mar 2001 20:53:36 -0500
Subject: Re: [jford@tusc.net: LUNA: Megaraid problems]
To: luna-list@luna.huntsville.al.us
Date: Tue, 6 Mar 2001 01:56:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010305153514.A789@frednet.dyndns.org> from "Matthew Fredrickson" at Mar 05, 2001 03:35:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6i2-0008Ei-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Works great with kernel 2.2.16.  Worked great up to kernel 2.3.99-test8 or
> so.  However under the current 2.4.x kernels (2.4.0, 2.4.1, 2.4.2) I get
> the following message:

Please test 2.4.2ac12. That has a much cleaned up megaraid.c 1.14g in it. I'd
like feedback before handing it on to Linus. Im using it here on a kernel
build disk with no problems

