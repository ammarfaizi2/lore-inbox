Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbTCHVJP>; Sat, 8 Mar 2003 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCHVJP>; Sat, 8 Mar 2003 16:09:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262207AbTCHVJL>;
	Sat, 8 Mar 2003 16:09:11 -0500
Date: Sat, 08 Mar 2003 13:01:12 -0800 (PST)
Message-Id: <20030308.130112.09061347.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cleanup nicstar, suni and idt77105
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303051616.h25GGTGi006786@locutus.cmf.nrl.navy.mil>
References: <200303051616.h25GGTGi006786@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch doesn't apply at all, it deletes lines referencing
idt77105_priv_lock but that does not appear in the sources.

This is the second patch in a row that produced tons of rejects for
me.  Please be more careful with patch generation in the future.

Thanks.
