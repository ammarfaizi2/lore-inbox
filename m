Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTJQKX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTJQKX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:23:59 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38100 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263382AbTJQKX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:23:58 -0400
Date: Fri, 17 Oct 2003 12:23:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031017102350.GA12845@louise.pinerecords.com>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl> <20031017095117.GB1690@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017095117.GB1690@tmathiasen>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-17 2003, Fri, 11:51 +0200
Torben Mathiasen <torben.mathiasen@hp.com> wrote:

> Funny you should send this as I was just looking at it. The good news is that
> it works!. We're not seeing any failed commands during boot anymore. I tested
> it on both 2.4.23-pre7 and 2.6.0-test7.

OK, I too can confirm this fix appears to work as expected.

Thanks!

-- 
Tomas Szepe <szepe@pinerecords.com>
