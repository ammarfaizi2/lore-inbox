Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264421AbRFSTDi>; Tue, 19 Jun 2001 15:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264722AbRFSTDS>; Tue, 19 Jun 2001 15:03:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264421AbRFSTDN>; Tue, 19 Jun 2001 15:03:13 -0400
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
To: steveu@coppice.org (Steve Underwood)
Date: Tue, 19 Jun 2001 20:01:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B2F91A5.49C7219C@coppice.org> from "Steve Underwood" at Jun 20, 2001 01:53:41 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CQlA-0006Tr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about "If you think you need threads, stop programming with closed
> sourced libraries where the documentation doesn't give you a clue how
> you might make things work within a state machine way"

Linux inherits several unix properties which are not friendly to good state
based programming - lack of good AIO for one.


