Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSJLCrT>; Fri, 11 Oct 2002 22:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSJLCrT>; Fri, 11 Oct 2002 22:47:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1665 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262779AbSJLCrS>;
	Fri, 11 Oct 2002 22:47:18 -0400
Date: Fri, 11 Oct 2002 19:46:26 -0700 (PDT)
Message-Id: <20021011.194626.45747152.davem@redhat.com>
To: miles@gnu.org, miles@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling without CONFIG_NET broken in 2.5.41
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <buo1y6xy582.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <buo1y6xy582.fsf@mcspd15.ucom.lsi.nec.co.jp>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Miles Bader <miles@lsi.nec.co.jp>
   Date: 11 Oct 2002 13:22:37 +0900

   It seems to work fine, but I have no idea if this is really the
   correct solution or not.

It looks fine, patch applied.
