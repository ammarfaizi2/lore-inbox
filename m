Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVGLAO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVGLAO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVGKT5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:57:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262548AbVGKTxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:53:10 -0400
Date: Mon, 11 Jul 2005 12:53:05 -0700 (PDT)
Message-Id: <20050711.125305.08322243.davem@davemloft.net>
To: halr@voltaire.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0/29v2] InfiniBand core update
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1121110249.4389.4984.camel@hal.voltaire.com>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org
people!  Condense your changes into more manageable pieces
or only submit smaller groups of changes at a time.

You people doing this are absolutely killing vger.kernel.org.

Every patch you post has to go to 5000+ subscribers, so please
keep this in mind when posting multiple patches.  If you feel
the need to send, say, more than 15 patches at once, reconsider.
