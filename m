Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTKUNcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 08:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKUNcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 08:32:48 -0500
Received: from denise.shiny.it ([194.20.232.1]:36515 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262190AbTKUNcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 08:32:47 -0500
Message-ID: <XFMail.20031121143243.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20031121123342.6cd41e22.ldecicco@gmx.net>
Date: Fri, 21 Nov 2003 14:32:43 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Luca De Cicco <ldecicco@gmx.net>
Subject: RE: TCP retransmissions per connection
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Nov-2003 Luca De Cicco wrote:
> Hi all...First of all, please excuse me if this is not the right place to post this question. If not
> please address me to the correct mailing list and i'll apologize.
>
> I want to keep track of TCP retransmissions for all TCP connections. I need this to compare
> retransmissions with a new congestion control algorithm i developed for my thesis.
> Is there a place or a way to get values?

man tcpdump


--
Giuliano.
