Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTLOXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTLOXP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:15:28 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:33982 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S264308AbTLOXPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:15:24 -0500
Date: Mon, 15 Dec 2003 15:15:15 -0800
Message-Id: <200312152315.hBFNFFw6024982@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: Ingo Molnar's message of  Monday, 15 December 2003 00:08:27 +0100 <Pine.LNX.4.58.0312142358210.16392@earth>
X-Windows: putting new limits on productivity.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo's final patch looks good to me.
