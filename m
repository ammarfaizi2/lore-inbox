Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTLOQS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTLOQS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:18:56 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:45291 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263728AbTLOQS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:18:56 -0500
From: dan carpenter <error27@email.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
Date: Mon, 15 Dec 2003 05:07:07 -0800
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
References: <20031214052516.GA313@vana.vc.cvut.cz> <200312142230.20952.error27@email.com> <Pine.LNX.4.58.0312151241340.27124@earth>
In-Reply-To: <Pine.LNX.4.58.0312151241340.27124@earth>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312150507.07228.error27@email.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 December 2003 03:43 am, Ingo Molnar wrote:
>
> do they go away if you do a kill -CONT on them?
>
> 	Ingo

Yes, they do.   Thanks.

regards,
dan carpenter

