Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbTCaVce>; Mon, 31 Mar 2003 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTCaVcd>; Mon, 31 Mar 2003 16:32:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6786 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261867AbTCaVcc>;
	Mon, 31 Mar 2003 16:32:32 -0500
Date: Mon, 31 Mar 2003 13:39:39 -0800 (PST)
Message-Id: <20030331.133939.35029434.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sparc] Default target
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030331160633.B5930@devserv.devel.redhat.com>
References: <20030331160633.B5930@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Mon, 31 Mar 2003 16:06:33 -0500

   Apparently, Sam changed his mind about the "makeboot", too.
   In 2.5.66, only s390, sparc64, and ppc64 still have it.
   
Well, since your previous sparc Makefile patches are in
the tree already, this patch has no chance to apply.
