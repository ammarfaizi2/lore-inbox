Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTEOURn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264249AbTEOURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:17:43 -0400
Received: from holomorphy.com ([66.224.33.161]:20177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264248AbTEOURl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:17:41 -0400
Date: Thu, 15 May 2003 13:26:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.5 kernels fail to start second CPU
Message-ID: <20030515202631.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <20030515184445.GQ8978@holomorphy.com> <Pine.LNX.3.96.1030515151950.30986A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030515151950.30986A-100000@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, William Lee Irwin III wrote:
>> What on earth are you getting on about?

On Thu, May 15, 2003 at 03:26:36PM -0400, Bill Davidsen wrote:
> I want to benchmark the box using one or two CPUs, with and without
> hyperthreading, as listed in the configurations above. To do this I want
> to use the boot options also listed in the original post above. I can
> reboot the box remotely but I can't physically remove a cpu to get the
> single cpu+ht config, so I'm looking for boot line options to provide
> that.

Please describe the following:
(1) what options you passed (.config if it differs between boots)
(2) how many cpus you expected
(3) how many cpus you got

for whatever you're doing that appears to go wrong.


On Thu, 15 May 2003, William Lee Irwin III wrote:
>> ia32 is utter crap with respect to power management, virtualization,
>> and generalized firmware.
>> If you don't have remote power management, buy it in whatever form
>> possible.

On Thu, May 15, 2003 at 03:26:36PM -0400, Bill Davidsen wrote:
> I'm not trying to manage the power, it's not a laptop, I'm trying to run
> benchmarks as noted in the first sentence of my question. I don't see
> how you got from there to virtualization from how to start (or not) cpus.

It sounded like what you were talking about. Maybe I get too many
people pushing feature requests as bugs.


-- wli
