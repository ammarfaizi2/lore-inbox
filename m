Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTDQBJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTDQBJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:09:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9610 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262197AbTDQBJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:09:55 -0400
Date: Wed, 16 Apr 2003 18:14:46 -0700 (PDT)
Message-Id: <20030416.181446.115340934.davem@redhat.com>
To: riel@surriel.com
Cc: chas@cmf.nrl.navy.mil, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for br2684
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@surriel.com>
   Date: Wed, 16 Apr 2003 21:08:43 -0400 (EDT)

   It looks like the recent ATM updates forgot br2684.c, here is
   the patch needed to make that driver compile.

Applied, thanks Rik.
