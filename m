Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbTEZGvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTEZGvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:51:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26761 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264302AbTEZGvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:51:22 -0400
Date: Mon, 26 May 2003 00:04:00 -0700 (PDT)
Message-Id: <20030526.000400.32747758.davem@redhat.com>
To: schlicht@uni-mannheim.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305260835.57145.schlicht@uni-mannheim.de>
References: <200305241637.07395.schlicht@uni-mannheim.de>
	<20030525.191818.48503212.davem@redhat.com>
	<200305260835.57145.schlicht@uni-mannheim.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Schlichter <schlicht@uni-mannheim.de>
   Date: Mon, 26 May 2003 08:35:53 +0200

   In version 1.26 of the file net/ipv4/esp.c rusty already added the static 
   initializer into the struct.

My error, sorry I hadn't noticed that.

Could you please resend the patches to me?  I've misplaced the
original copy.
