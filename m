Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTDQBIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTDQBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:08:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7818 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262196AbTDQBIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:08:35 -0400
Date: Wed, 16 Apr 2003 18:13:17 -0700 (PDT)
Message-Id: <20030416.181317.107894203.davem@redhat.com>
To: riel@surriel.com
Cc: coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix ipfw
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0304162109530.12650-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0304162109530.12650-100000@chimarrao.boston.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@surriel.com>
   Date: Wed, 16 Apr 2003 21:11:31 -0400 (EDT)
   
   This patch gets rid of that (presumably old) code block. Note
   that I didn't cc this to Marcelo because I'm not 100% sure, so
   please check it.

Thanks, I got this fix independantly already.  It is correct.
