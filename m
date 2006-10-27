Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946238AbWJ0IGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946238AbWJ0IGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWJ0IGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:06:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52757 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946237AbWJ0IGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:06:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=aQe1+9gogu5xZDzqH2uwSd9Tl1v2gxZiTF9/6RLCbXmQuFdwAhDFRjREAF9fSrJMaNXnusU/vPjse3tgHK9L5oQm7k2u+QvdpjR/nTY69NsWCAegcV2XtE21PZyTcB+YsX1XTEkugdM9B9k91OwcmtchigxMcmYHDWIFZhgop1c=
Subject: O2 micro OZ711Mx mmc driver
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 10:04:39 +0200
Message-Id: <1161936280.3937.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. Sorry for sending again, but my email didn't reach LKML, for
some reason.

Here it is through the web interface ..

http://lkml.org/lkml/2006/10/26/181

In short I have contacted O2 Micro for a driver for my MMC card reader
OZ711Mx and they sent me a driver tarball under the GPL. It is made for
2.6.16 and doesn't compile with recent kernels.

I fixed it to compile but it still doesn't work. I am trying as hard as
I can to fix it but my programming knowledge is limited. Any help is
appreciated.

Thank you.

