Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbTCWJGB>; Sun, 23 Mar 2003 04:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbTCWJGB>; Sun, 23 Mar 2003 04:06:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61891 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262988AbTCWJF7>;
	Sun, 23 Mar 2003 04:05:59 -0500
Date: Sun, 23 Mar 2003 01:14:56 -0800 (PST)
Message-Id: <20030323.011456.82586011.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] s/uni driver overwrites 8-/16-bit mode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303211705.h2LH5BGi002669@locutus.cmf.nrl.navy.mil>
References: <200303211705.h2LH5BGi002669@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Fri, 21 Mar 2003 12:05:10 -0500

   on the s/uni 622 chip, the uppermost bit of the Master Test register
   controls the width of the data bus.  this is unused in the older s/uni
   chips.
   
Applied, thanks Chas.
