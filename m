Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWGNVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWGNVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 17:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWGNVB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 17:01:57 -0400
Received: from jg555.com ([64.30.195.78]:1152 "EHLO jg555.com")
	by vger.kernel.org with ESMTP id S1161124AbWGNVB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 17:01:57 -0400
Message-ID: <44B80543.4050608@jg555.com>
Date: Fri, 14 Jul 2006 13:57:39 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: dwmw2@infradead.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
References: <44B7F062.8040102@jg555.com>	<1152905987.3159.46.camel@laptopd505.fenrus.org>	<1152908202.3191.98.camel@pmac.infradead.org> <20060714.131957.57444250.davem@davemloft.net>
In-Reply-To: <20060714.131957.57444250.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 When I wrote my script to sanitize, I was really surprised on which 
headers gets utilized and which ones didn't.. I have it down to the bare 
minimums in my script.

As far as glibc goes, from my people who are helping me the alpha 
architecture is the culprit there.

Do we have a list of what headers are "user-space" and which ones should 
not be "user-space"?

Also David W, let me know what I can do to help you out, a lot of people 
on my end want to get this working properly.

Who's maintaining util-linux these days, we probably should get a patch 
to them.



