Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275003AbRJNJjn>; Sun, 14 Oct 2001 05:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275012AbRJNJjX>; Sun, 14 Oct 2001 05:39:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S275003AbRJNJjU>;
	Sun, 14 Oct 2001 05:39:20 -0400
Date: Sun, 14 Oct 2001 02:39:48 -0700 (PDT)
Message-Id: <20011014.023948.95894368.davem@redhat.com>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <k2zo6uiney.fsf@zero.aec.at>
In-Reply-To: <3BC94F3A.7F842182@welho.com>
	<20011014.020326.18308527.davem@redhat.com>
	<k2zo6uiney.fsf@zero.aec.at>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: 14 Oct 2001 11:25:09 +0200
   
   but at least here is an counter example
   now that may be a good case for a reconsider.

A buggy 2.2.x kernel is not a good case counter example.

Franks a lot,
David S. Miller
davem@redhat.com
