Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTEGIqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTEGIqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 04:46:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36736 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262977AbTEGIqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 04:46:42 -0400
Date: Wed, 07 May 2003 00:51:39 -0700 (PDT)
Message-Id: <20030507.005139.112602434.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] forerunner he support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305070014.h470EHi02991@relax.cmf.nrl.navy.mil>
References: <200305070014.h470EHi02991@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Tue, 6 May 2003 20:14:17 -0400

   want to get this into the kernel tree before i start making
   the smp fixes.  should i submit the 2.4 config bits? 
   
Applied.  I took care of the 2.4.x bits.

BTW, can we ditch the "EXTRA_CFLAGS=-g" thing in drivers/atm/Makefile?
:-)
