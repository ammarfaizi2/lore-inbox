Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbSLLTzM>; Thu, 12 Dec 2002 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbSLLTzM>; Thu, 12 Dec 2002 14:55:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265097AbSLLTzL>;
	Thu, 12 Dec 2002 14:55:11 -0500
Date: Thu, 12 Dec 2002 11:58:53 -0800 (PST)
Message-Id: <20021212.115853.111618106.davem@redhat.com>
To: stefano.andreani.ap@h3g.it
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Kernel bug handling TCP_RTO_MAX?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
References: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Andreani Stefano" <stefano.andreani.ap@h3g.it>
   Date: Thu, 12 Dec 2002 20:15:42 +0100

   Problem: I need to change the max value of the TCP retransmission
   timeout.

Why?  There should be zero reason to change this value.
