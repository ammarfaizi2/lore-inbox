Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTEMXww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTEMXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:52:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50327 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263580AbTEMXwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:52:50 -0400
Date: Tue, 13 May 2003 17:05:19 -0700 (PDT)
Message-Id: <20030513.170519.15252987.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make clip modular 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305132131.h4DLVGGi003551@locutus.cmf.nrl.navy.mil>
References: <200305122140.h4CLedGi030882@locutus.cmf.nrl.navy.mil>
	<200305132131.h4DLVGGi003551@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Tue, 13 May 2003 17:31:16 -0400

   ok, how about this one.  this should fix all of the atm_clip_ops racy
   references.
   
This looks a lot better, I'll apply this.

Thanks.
