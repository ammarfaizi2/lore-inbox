Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbRFSUXo>; Tue, 19 Jun 2001 16:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbRFSUXf>; Tue, 19 Jun 2001 16:23:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16146 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264764AbRFSUX3>; Tue, 19 Jun 2001 16:23:29 -0400
Subject: Re: Linux 2.2.20-pre4
To: kloczek@rudy.mif.pg.gda.pl (=?ISO-8859-2?Q?Tomasz_K=B3oczko?=)
Date: Tue, 19 Jun 2001 21:22:07 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106192200521.3184-100000@rudy.mif.pg.gda.pl> from "=?ISO-8859-2?Q?Tomasz_K=B3oczko?=" at Jun 19, 2001 10:03:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CS0l-0006co-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 19 Jun 2001, Alan Cox wrote:
> [..]
> > o	Fix refclock build with newer gcc		(Jari Ruusu)
> 
> Is it mean now kernel 2.2 with prepatch is (or will be) gcc 3.0 ready ?
> If not what must be fixed/chenged to be ready ?

It wont build with gcc 3.0 yet. To start with gcc 3.0 will assume it can
insert calls to 'memcpy' 
