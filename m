Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287530AbRLaNNr>; Mon, 31 Dec 2001 08:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287529AbRLaNNd>; Mon, 31 Dec 2001 08:13:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43022 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287527AbRLaNM7>; Mon, 31 Dec 2001 08:12:59 -0500
Subject: Re: [patch] A slightly smarter dmi_scan.c ?
To: ioshadi@sltnet.lk (Alvin of Diaspar)
Date: Mon, 31 Dec 2001 13:23:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, james@and.org
In-Reply-To: <3C309FB1.63544633@sltnet.lk> from "Alvin of Diaspar" at Dec 31, 2001 11:26:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2Pa-00053f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	James, Alan is right. No need for #ifdef's *when* (and only when)
> there's a better way to do it. Thanks.

Looks ok to me
