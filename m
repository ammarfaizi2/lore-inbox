Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSGRHlu>; Thu, 18 Jul 2002 03:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGRHlu>; Thu, 18 Jul 2002 03:41:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21224 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316849AbSGRHlt>;
	Thu, 18 Jul 2002 03:41:49 -0400
Date: Thu, 18 Jul 2002 00:34:56 -0700 (PDT)
Message-Id: <20020718.003456.133418078.davem@redhat.com>
To: abhipatil@mbplindia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <51A836284489D611B1AC00D0B7B179E7A408@SINDHU_PR>
References: <51A836284489D611B1AC00D0B7B179E7A408@SINDHU_PR>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "AbhinandanPatil" <abhipatil@mbplindia.com>
   Date: Thu, 18 Jul 2002 12:32:33 -0700

        where can i get the details of sk_buff structure.
   i want the details of each member in this buffer.

include/linux/skbuff.h is a great place to get this
information.
