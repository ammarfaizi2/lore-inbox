Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSAJWA6>; Thu, 10 Jan 2002 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289723AbSAJWAk>; Thu, 10 Jan 2002 17:00:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289727AbSAJWA0>; Thu, 10 Jan 2002 17:00:26 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Thu, 10 Jan 2002 22:11:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pbadari@us.ibm.com (Badari Pulavarty),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201102153.g0ALrl402482@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 10, 2002 01:53:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OnQ6-0005gz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something like sd_attach() could get this info from template and
> set a flag in blk_dev. (or in a gloal array).

I didnt think blk_dev was per minor ?
