Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbSJNTxu>; Mon, 14 Oct 2002 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJNTxt>; Mon, 14 Oct 2002 15:53:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57756 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262144AbSJNTxs>;
	Mon, 14 Oct 2002 15:53:48 -0400
Date: Mon, 14 Oct 2002 12:52:34 -0700 (PDT)
Message-Id: <20021014.125234.102091817.davem@redhat.com>
To: genlogic@inrete.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAB1F00.667B82B5@inrete.it>
References: <3DAB1F00.667B82B5@inrete.it>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniele Lugli <genlogic@inrete.it>
   Date: Mon, 14 Oct 2002 21:46:08 +0200
   
   Moral of the story: in my opinion kernel developers should reduce to a
   minimum the use of #define, and preferably use words in uppercase and/or
   with underscores, in any case not commonly used words.

Or maybe you should change your datastructure to not have member names
the conflict with 7 year old well defined global symbols in the Linux
kernel?
