Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755244AbWKMTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbWKMTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbWKMTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:50:28 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:21225 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1755244AbWKMTu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:50:27 -0500
Message-ID: <4558CC84.4050304@billgatliff.com>
Date: Mon, 13 Nov 2006 13:50:28 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Thiago Galesi <thiagogalesi@gmail.com>, Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <82ecf08e0611130956m9f30bf0t2a7b62307d5f70ca@mail.gmail.com> <200611131125.52984.david-b@pacbell.net>
In-Reply-To: <200611131125.52984.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> - gpio_set_value() ... implementations can lock internally, as needed.
>   ditto gpio_get_value(), but only bizarre hardware would need it.
>  
>

"bizarre" ~= "ppc", at least.  But I'd hardly argue with that 
characterization most days.  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

