Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbTLHPy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265458AbTLHPy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:54:27 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:8079 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265436AbTLHPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:54:25 -0500
X-Sender-Authentication: net64
Date: Mon, 8 Dec 2003 16:54:23 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: mark@symonds.net, linux-kernel@vger.kernel.org, davem@redhat.com,
       wli@holomorphy.com, laforge@netfilter.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-Id: <20031208165423.555c5783.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0312080815460.30140-100000@logos.cnet>
References: <008501c3bd18$697361e0$7a01a8c0@gandalf>
	<Pine.LNX.4.44.0312080815460.30140-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 08:17:30 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> Mark,
> 
> Please try the latest BK tree. There was a known bug in the netfilter code 
> which could cause the lockups. 

...which leads me to the most-simple question: where can I find a changelog for
2.4.23-bkX from www.kernel.org ? Inside ?

Regards,
Stephan
