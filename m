Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLXB22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLXB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:28:28 -0500
Received: from mx1.net.titech.ac.jp ([131.112.125.25]:47112 "HELO
	mx1.net.titech.ac.jp") by vger.kernel.org with SMTP id S263281AbTLXB2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:28:25 -0500
Date: Wed, 24 Dec 2003 10:28:22 +0900 (JST)
Message-Id: <20031224.102822.71105854.ryutaroh@it.ss.titech.ac.jp>
To: junkio@cox.net
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
From: ryutaroh@it.ss.titech.ac.jp
In-Reply-To: <7v4qvrtfo3.fsf@assigned-by-dhcp.cox.net>
References: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
	<fa.kfih9j0.q4e8bi@ifi.uio.no>
	<7v4qvrtfo3.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junio C Hamano <junkio@cox.net>
> rm> We cannot input | (bar) with the JP 106 keyboards (the standard Japanese
> rm> keyboards).
> Known problem.  Look for string "Japanese" in the post-halloween doc.
> http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt

Thank you for your comments.
I understand the situation.

Ryutaroh
