Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750799AbWFEXR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFEXR5 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWFEXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:17:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:10962 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750799AbWFEXR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:17:56 -0400
Subject: Re: [patch-rt 2/2] Add clocksource driver for Versatile board
From: john stultz <johnstul@us.ibm.com>
To: dsaxena@plexity.net
Cc: mingo@elte.hu, tglx@linutronix.de, dwalker@mvista.com,
        james.perkins@windriver.com, linux-kernel@vger.kernel.org,
        rmk@arm.linux.org.uk, khilman@mvista.com
In-Reply-To: <20060605224438.617881000@localhost.localdomain>
References: <20060605222956.608067000@localhost.localdomain>
	 <20060605224438.617881000@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 16:17:53 -0700
Message-Id: <1149549473.11470.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 15:29 -0700, dsaxena@plexity.net wrote:
> plain text document attachment (arm-versatile-hrt.patch)
> This patch adds a clocksource driver for the ARM versatile board,
> allowing it to use the generic time-of-day code.

Code looks good to me!

thanks
-john

