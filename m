Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUEJO6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUEJO6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbUEJO6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:58:53 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:38001 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264723AbUEJO6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:58:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 May 2004 07:58:50 -0700
In-Reply-To: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
Message-ID: <52pt9cpbv9.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2004 14:58:50.0339 (UTC) FILETIME=[4DA22B30:01C4369F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I have found a severe problem in Linux 2.6.6 that has a
major impact on all users: the NAME variable in the top-level Makefile
remains set to "Zonked Quokka," _unchanged from Linux 2.6.5_.

I am unsure of the correct value of NAME, or else I would post a patch.

 - Roland

