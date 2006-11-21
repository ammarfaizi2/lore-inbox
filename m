Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966904AbWKUC4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966904AbWKUC4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966905AbWKUC4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:56:00 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:17578 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S966904AbWKUC4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:56:00 -0500
Message-ID: <45626AC1.4030308@billgatliff.com>
Date: Mon, 20 Nov 2006 20:56:01 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <4558C794.90602@billgatliff.com> <20061113201535.GA20388@linux-sh.org> <200611201415.19095.david-b@pacbell.net>
In-Reply-To: <200611201415.19095.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>I could certainly take all that feedback and let it lead me to some particular
>implementation -- example, a table of { controller, index, flags } structs indexed
>by the GPIO numbers, with controller ops vectors matching the primitives -- but
>even if that were to happen, I'd like to know if anyone has any major disagreement
>with the summary above.
>  
>


Your summary agrees with me.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

