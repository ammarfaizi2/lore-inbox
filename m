Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTDNW2Z (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTDNW2Z (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:28:25 -0400
Received: from smtp.bhfc.net ([209.159.192.11]:16558 "EHLO smtp.bhfc.net")
	by vger.kernel.org with ESMTP id S264021AbTDNW2Y (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:28:24 -0400
From: Tim Lee <tlee5794@rushmore.com>
Reply-To: tlee5794@rushmore.com
To: linux-kernel@vger.kernel.org
Subject: Help with SiS 648 chipset and agpgart
Date: Mon, 14 Apr 2003 04:39:08 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304140439.08812.tlee5794@rushmore.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to get agpgart to work with a SiS 648 chipset and I
haven't seen any implementation of such yet.  I'm currently
using a 2.4.19 kernel.  Without a working implementation I
can't use accelerated OpenGL with an ATI Radeon 9500 pro
because the ATI drivers require working agp support.  I've
tried just using the generic-sis but that causes the driver
to mess up big time.

Any ideas?

Regards,
Tim Lee
