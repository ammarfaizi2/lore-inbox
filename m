Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSBDWgi>; Mon, 4 Feb 2002 17:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289236AbSBDWg0>; Mon, 4 Feb 2002 17:36:26 -0500
Received: from ns.ithnet.com ([217.64.64.10]:15371 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289234AbSBDWgR>;
	Mon, 4 Feb 2002 17:36:17 -0500
Date: Mon, 4 Feb 2002 23:35:51 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson
	<roger.larsson@norran.net>)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: New VM Testcase (2.4.18pre7 SWAPS) (2.4.17-rmap12b OK)
Message-Id: <20020204233551.76469dc6.skraw@ithnet.com>
In-Reply-To: <200202042227.g14MRFN12329@maile.telia.com>
In-Reply-To: <200202042227.g14MRFN12329@maile.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002 23:24:11 +0100
Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson <roger.larsson@norran.net>) wrote:

> When examining Karlsbakk problem I got into one quite different myself.
> 
> [...]
> 
> the 2.4.18pre7 goes into deep swap after awhile .
> It is impossible to start a new login, et.c. finally
> the dd processes begins to be OOM killed... not nice...
> 
> the 2.4.17-rmap12b handles this MUCH nicer!

What about -aa ?

Regards,
Stephan

