Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUEPXvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUEPXvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 19:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbUEPXvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 19:51:13 -0400
Received: from pD951CF4E.dip.t-dialin.net ([217.81.207.78]:16002 "EHLO
	defiant.crash") by vger.kernel.org with ESMTP id S264851AbUEPXvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 19:51:11 -0400
From: Ronald Lembcke <es186@fen-net.de>
Date: Mon, 17 May 2004 01:51:01 +0200
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 CPU Issue - Uses 50-55% of CPU when doing nothing.
Message-ID: <20040516235101.GA23052@defiant.crash>
References: <Pine.LNX.4.58.0405150504310.14958@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405150504310.14958@p500>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, May 15, 2004 at 05:10:42AM -0400, Justin Piszcz wrote:
> Top reports my CPU is 52% in use but top does not show any process using up
> a lot of CPU, and the temperature confirms it is running at 50%.
I just saw a similar thing on my computer ... than I noticed that
an xmms-visualisation-plugin was running. Obviously neither "top"
nor "ps" displayed all threads. ("ps" does with parameter "L").

ps / top should add the cpu-usage of all threads of each process
they display.

Und weg... 
           Roni
