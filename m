Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJSASI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 20:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJSASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 20:18:08 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:45000 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261914AbTJSASG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 20:18:06 -0400
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: test8: 'Debug: sleeping function called from invalid context'
References: <E1AB079-0001Yf-00@penngrove.fdns.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 18 Oct 2003 17:18:04 -0700
In-Reply-To: <E1AB079-0001Yf-00@penngrove.fdns.net>
Message-ID: <52r81a9j2b.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Oct 2003 00:18:05.0776 (UTC) FILETIME=[778CC500:01C395D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See the email I sent a little which ago with the subject

    [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot

That explains what's going on and has a patch that should get rid of
the warnings.

 - Roland
