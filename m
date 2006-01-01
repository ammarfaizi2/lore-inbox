Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWAAJOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWAAJOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 04:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWAAJOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 04:14:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932194AbWAAJOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 04:14:24 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Arjan van de Ven <arjan@infradead.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051231202933.4f48acab@galactus.example.org>
References: <20051231202933.4f48acab@galactus.example.org>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 10:14:21 +0100
Message-Id: <1136106861.17830.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> they all work fine under 2.6.14 and 2.6.14-rt21/22.
> 
> I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> every video I try and play. Yes, I have nvidia modules loaded, so won't
> get much help, but thought someone might like to know. 


you know, you could have done a little bit more effort and reproduced
this without the binary crud... it's not that hard you know and it shows
that you actually care about the problem enough that you want to make it
worthwhile for people to look into it.

