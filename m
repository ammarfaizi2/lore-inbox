Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVADN0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVADN0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVADN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:26:33 -0500
Received: from holomorphy.com ([207.189.100.168]:45190 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261625AbVADNYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:24:01 -0500
Date: Tue, 4 Jan 2005 05:14:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104131416.GF2708@holomorphy.com>
References: <20050103153438.GF2980@stusta.de> <1697129508.20050102210332@dns.toxicfilms.tv> <1104767943.4192.17.camel@laptopd505.fenrus.org> <41D9D69C.1070002@tmr.com> <1104824557.4215.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104824557.4215.1.camel@laptopd505.fenrus.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone wrote:
>>> The joint approach also has major advantages, even for quality:
>>> All testing happens on the same codebase. 
>>> Previously, the testing focus was split between the stable and unstable
>>> branch, to the detriment of *both*.

At some point in the past, someone else wrote:
>> You think so? I think the number of people testing the 2.4.xx-rc 
>> versions AND the 2.6.xx-bkN versions is a small (nonzero) percentage of 
>> total people trying any new release. I think people test what they plan 
>> to use, so there's less competition for testers than you suggest. People 
>> staying with 2.4 test that, people wanting or needing to move forward 
>> test 2.6.

On Tue, Jan 04, 2005 at 08:42:36AM +0100, Arjan van de Ven wrote:
> Actually I suspect the number of people testing 2.4.xx-rc is *really*
> small now. My point however was more towards a 2.6 / 2.7 split, where
> the people who want to test newest do 2.7 while people who want to test
> stable test 2.6; right now those two groups test basically the same
> codebase.

But this is a good thing; new code should meet the prior standards
of stability and correctness as should the tree at all times. Efforts
to recover it once it is lost to a large degree are doomed.


-- wli
