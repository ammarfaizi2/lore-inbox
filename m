Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTIPOhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTIPOhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:37:04 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:19851 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261925AbTIPOhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:37:00 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 16:36:58 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916163658.4b1a8c5c.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0309161132530.1636-100000@logos.cnet>
References: <20030916153658.3081af6c.skraw@ithnet.com>
	<Pine.LNX.4.44.0309161132530.1636-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 11:33:27 -0300 (BRT)
Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:

> > Well, I do understand the bounce buffer problem, but honestly the current way
> > of handling the situation seems questionable at least. If you ever tried such a
> > system you notice it is a lot worse than just dumping the additional ram above
> > 4GB. You can really watch your network connections go bogus which is just
> > unacceptable. 
> 
> All is fine with 4GB? 

Absolutely perfect.

Regards,
Stephan
