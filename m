Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCJTGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUCJTGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:06:34 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:12748 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262574AbUCJTGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:06:30 -0500
To: David Ford <david+challenge-response@blue-labs.org>
Cc: root@chaos.analogic.com, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
	<20040310100215.1b707504.rddunlap@osdl.org>
	<Pine.LNX.4.53.0403101324120.18709@chaos>
	<404F6375.3080500@blue-labs.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Mar 2004 11:06:28 -0800
In-Reply-To: <404F6375.3080500@blue-labs.org>
Message-ID: <52ad2o4j4b.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2004 19:06:29.0198 (UTC) FILETIME=[CB015EE0:01C406D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Really, your mail reading software should be capable of
    David> wrapping things by itself, we really have progressed from
    David> yesteryear.

The problem is that if (say) you use 100 character lines, then someone
reading it in an 80-column window sees 80-char line, 20-char line, etc
etc and it's very annoying to read.  If you make every paragraph one
huge line, then when someone wants to quote your message, they have to
wrap the quote themselves.

Keeping email lines to about 70 characters is still the best policy.

 - Roland
