Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264882AbSKEQAb>; Tue, 5 Nov 2002 11:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSKEQAb>; Tue, 5 Nov 2002 11:00:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264882AbSKEQA3>;
	Tue, 5 Nov 2002 11:00:29 -0500
Date: Tue, 05 Nov 2002 08:59:41 -0800 (PST)
Message-Id: <20021105.085941.119272261.davem@redhat.com>
To: kai-germaschewski@uiowa.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.46
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211050958470.20254-100000@chaos.physics.uiowa.edu>
References: <1036477834.31982.0.camel@rth.ninka.net>
	<Pine.LNX.4.44.0211050958470.20254-100000@chaos.physics.uiowa.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
   Date: Tue, 5 Nov 2002 10:02:26 -0600 (CST)
   
   I suppose that's because sparc64 doesn't properly define LDFLAGS_BLOB (nor 
   did it define ARCHBLOBFLAGS, which is replaced by the former now). Look 
   at arch/i386/Makefile::LDFLAGS_BLOB and adapt accordingly ;)

Precisely, I have it working now.  Thanks!
