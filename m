Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264965AbRFZPD0>; Tue, 26 Jun 2001 11:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264967AbRFZPDR>; Tue, 26 Jun 2001 11:03:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:46124 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264965AbRFZPDG>; Tue, 26 Jun 2001 11:03:06 -0400
Date: Tue, 26 Jun 2001 17:02:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bulent Abali <abali@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
Message-ID: <20010626170255.A554@athlon.random>
In-Reply-To: <OF29D2C834.F627AA03-ON85256A77.0050F2F6@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF29D2C834.F627AA03-ON85256A77.0050F2F6@pok.ibm.com>; from abali@us.ibm.com on Tue, Jun 26, 2001 at 10:47:12AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 10:47:12AM -0400, Bulent Abali wrote:
> Andrea,
> I would like try your patch but so far I can trigger the bug only when
> running TUX 2.0-B6 which runs on 2.4.5-ac4.  /bulent
> 

to run tux you can apply those patches in `ls` order to 2.4.6pre5aa1:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/30_tux/*

Andrea
