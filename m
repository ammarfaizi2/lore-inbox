Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTHLKSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTHLKSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:18:49 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:51592 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S269602AbTHLKSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:18:47 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 12 Aug 2003 12:18:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: maney@pobox.com
Cc: maney@two14.net, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-Id: <20030812121844.521dcca3.skraw@ithnet.com>
In-Reply-To: <20030812035803.GA17921@furrr.two14.net>
References: <20030812035803.GA17921@furrr.two14.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 22:58:03 -0500
maney@two14.net (Martin Maney) wrote:

> 
> Okay, further testing is clearly indicated (and I'm recompiling a test
> kernel while writing this to try to narrow it down a little), but I've
> got a very repeatable file corruption under 2.4.22-rc2 that does not
> manifest under 2.4.21.  My repeatable test case only (so far?) causes
> the data in the file to be corrupted, but I suspect metadata can get
> hit as well, and I have seen some filesystem errors that were probably
> caused by this, but not so that I can say so with certainty.

Did you do a long check of your system memory with memtest? long meaning some
days...

Regards,
Stephan
