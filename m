Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbTLMTFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTLMTFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:05:15 -0500
Received: from holomorphy.com ([199.26.172.102]:26498 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265290AbTLMTFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:05:10 -0500
Date: Sat, 13 Dec 2003 11:05:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031213190502.GR8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gabor MICSKO <gmicsko@szintezis.hu>,
	LKML <linux-kernel@vger.kernel.org>
References: <20031211052929.GN19856@holomorphy.com> <1071342114.561.3.camel@gmicsko03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071342114.561.3.camel@gmicsko03>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003-12-11, cs keltez?ssel William Lee Irwin III ezt ?rta:
>> Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. 

On Sat, Dec 13, 2003 at 08:01:51PM +0100, Gabor MICSKO wrote:
> Hi!
> Can't boot on my IBM Thinkpad R32. On boot falling in infinite loop. 
> .config attached

Can you try without 4K stacks? PCMCIA sometimes barfs on that.


-- wli
