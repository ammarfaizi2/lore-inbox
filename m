Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSJPACm>; Tue, 15 Oct 2002 20:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSJPACm>; Tue, 15 Oct 2002 20:02:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32170 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265139AbSJPACk>;
	Tue, 15 Oct 2002 20:02:40 -0400
Date: Tue, 15 Oct 2002 17:01:22 -0700 (PDT)
Message-Id: <20021015.170122.73927321.davem@redhat.com>
To: levon@movementarian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016000623.GA45945@compsoc.man.ac.uk>
References: <20021015223255.GB41906@compsoc.man.ac.uk>
	<20021015.163749.38782953.davem@redhat.com>
	<20021016000623.GA45945@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Wed, 16 Oct 2002 01:06:23 +0100

   On Tue, Oct 15, 2002 at 04:37:49PM -0700, David S. Miller wrote:
   
   > Can you make the dcookie a fixed sized type such
   
   Look OK ?

Yes, thank you.

   
