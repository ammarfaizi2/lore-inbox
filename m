Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSIAHwT>; Sun, 1 Sep 2002 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSIAHwT>; Sun, 1 Sep 2002 03:52:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41664 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316545AbSIAHwT>;
	Sun, 1 Sep 2002 03:52:19 -0400
Date: Sun, 01 Sep 2002 00:50:25 -0700 (PDT)
Message-Id: <20020901.005025.55836430.davem@redhat.com>
To: rudmer@legolas.dynup.net
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix __FUNCTION__ use in ip_nat_helper.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901074925.6153.qmail@legolas.dynup.net>
References: <20020901074925.6153.qmail@legolas.dynup.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: rudmer@legolas.dynup.net
   Date: 1 Sep 2002 07:49:25 -0000
   
   both due to bad use of __FUNCTION__ patch follows

Rusty no need to take this, I pushed it to Linus about
an hour ago.
