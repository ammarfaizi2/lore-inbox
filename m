Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTDIH5w (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTDIH5v (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:57:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9663 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262893AbTDIH5u (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:57:50 -0400
Date: Wed, 09 Apr 2003 01:03:48 -0700 (PDT)
Message-Id: <20030409.010348.23879845.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] ia64 doesn't know about atm drivers on 2.4 kernels
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304081312.h38DCFGi018652@locutus.cmf.nrl.navy.mil>
References: <200304081312.h38DCFGi018652@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Tue, 08 Apr 2003 09:12:15 -0400

   the ia64 arch doesnt seem to know about the atm drivers.  please apply this
   to the 2.4 series.
   
   Index: linux/arch/ia64/config.in

Done.
