Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288020AbSAUTyG>; Mon, 21 Jan 2002 14:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288010AbSAUTx4>; Mon, 21 Jan 2002 14:53:56 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:37422 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S288020AbSAUTxq> convert rfc822-to-8bit; Mon, 21 Jan 2002 14:53:46 -0500
Date: Mon, 21 Jan 2002 20:52:51 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Edward Shushkin <edward@namesys.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: scsi ncr53c8XX again
In-Reply-To: <3C4C70A8.86BA02A4@namesys.com>
Message-ID: <20020121205106.S1793-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jan 2002, Edward Shushkin wrote:

> Anybody has a patch against 2.5.2 to make it compile and work?
> Thank you in advance.

Is there something wrong with SYM53C8XX_2 ? (The '_2' is important)
This driver also supports old ncr53c8xx chips.

  Gérard.

