Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRFGSFe>; Thu, 7 Jun 2001 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbRFGSFZ>; Thu, 7 Jun 2001 14:05:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262694AbRFGSFO>; Thu, 7 Jun 2001 14:05:14 -0400
Subject: Re: 2.2.20 pre2 compilation broken
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Thu, 7 Jun 2001 19:03:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20010607051511.44709.qmail@web10401.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at Jun 07, 2001 03:15:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15848C-0001gX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/filesystems.a(reiserfs.o): In function
> `ip_check_balance':
> reiserfs.o(.text+0x9dde): undefined reference to

This isnt Linux 2.2. Linux 2.2 does not include reiserfs.
