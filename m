Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTEJPNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTEJPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:13:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55706 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264353AbTEJPNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:13:06 -0400
Date: Sat, 10 May 2003 08:25:01 -0700 (PDT)
Message-Id: <20030510.082501.35689494.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: hch@infradead.org, romieu@fr.zoreil.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE
 he_init_one() (and an iphase patch too!) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305101518.h4AFIWGi014599@locutus.cmf.nrl.navy.mil>
References: <20030510.070234.21899554.davem@redhat.com>
	<200305101518.h4AFIWGi014599@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sat, 10 May 2003 11:18:32 -0400

   In message <20030510.070234.21899554.davem@redhat.com>,"David S. Miller" writes:
   >   but its ok for usb drivers?
   >Bad ugly code in one area of the kernel is not an excuse
   >for it in other areas :-)
   
   perhaps someone should mention this to them?  i believe usb
   is under active development.
   
We just did.  :-)

And a coding style document lives in the tree in case you weren't
aware of this.  linux/Documentation/CodingStlye

   [ATM]: unbalanced exit path in Forerunner HE he_init_one().  thanks to
          Francois Romieu <romieu@fr.zoreil.com>
   
I'll apply this, thanks.
