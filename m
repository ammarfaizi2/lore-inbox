Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272517AbRH3V75>; Thu, 30 Aug 2001 17:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272516AbRH3V7h>; Thu, 30 Aug 2001 17:59:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11667 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272514AbRH3V72>;
	Thu, 30 Aug 2001 17:59:28 -0400
Date: Thu, 30 Aug 2001 14:56:09 -0700 (PDT)
Message-Id: <20010830.145609.42773013.davem@redhat.com>
To: val@nmt.edu
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Lost TCP retransmission timer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010830121025.A15880@boardwalk>
In-Reply-To: <20010829195259.B11544@boardwalk>
	<200108301621.UAA05134@ms2.inr.ac.ru>
	<20010830121025.A15880@boardwalk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Val Henson <val@nmt.edu>
   Date: Thu, 30 Aug 2001 12:10:25 -0600

   On Thu, Aug 30, 2001 at 08:21:16PM +0400, kuznet@ms2.inr.ac.ru wrote:
   > Your hopes were groundless.
   > Actually, you could change subject, this apparently has nothing
   > to do with your problem and this is misleading.
   
   You're right.  I thought the subject was "tcp connection hangs." :)

BTW, you mentioned that you are seeing this on PPC, do you have any
way to verify if the bug can be triggered on any other platform?

Later,
David S. Miller
davem@redhat.com
