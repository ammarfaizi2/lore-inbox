Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTDQCF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 22:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTDQCF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 22:05:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262502AbTDQCFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 22:05:55 -0400
Date: Wed, 16 Apr 2003 19:10:44 -0700 (PDT)
Message-Id: <20030416.191044.29598803.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: riel@surriel.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for br2684 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304170153.h3H1rOGi007109@locutus.cmf.nrl.navy.mil>
References: <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>
	<200304170153.h3H1rOGi007109@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 16 Apr 2003 21:53:24 -0400

   forgive me, but i didnt think the recvq to sk->receive_queue changes were
   in the 2.4 kernel series yet?
   
I'm backporting all of your ATM fixes to 2.4.x as you send them to
me for 2.5.x.
