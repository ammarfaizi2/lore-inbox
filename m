Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312271AbSCTXQv>; Wed, 20 Mar 2002 18:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312275AbSCTXQo>; Wed, 20 Mar 2002 18:16:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12049 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312271AbSCTXQb>; Wed, 20 Mar 2002 18:16:31 -0500
Subject: Re: 2.4.19-pre3-ac4 compile failure on Alpha
To: schmali@ritman.com (Robert Schmaling)
Date: Wed, 20 Mar 2002 23:32:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001501c1d053$0925cde0$0201a8c0@idlewild.net> from "Robert Schmaling" at Mar 20, 2002 04:05:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16npZP-0003f2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compilation fails with the following :

Yep -ac alpha has not been updated for the O(1) scheduler
