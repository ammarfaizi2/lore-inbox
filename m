Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbTLMVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTLMVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 16:09:26 -0500
Received: from holomorphy.com ([199.26.172.102]:45954 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265296AbTLMVJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 16:09:26 -0500
Date: Sat, 13 Dec 2003 13:09:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gabor MICSKO <gmicsko@szintezis.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031213210920.GS8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gabor MICSKO <gmicsko@szintezis.hu>,
	LKML <linux-kernel@vger.kernel.org>
References: <20031211052929.GN19856@holomorphy.com> <1071342114.561.3.camel@gmicsko03> <20031213190502.GR8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213190502.GR8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003-12-11, cs keltez?ssel William Lee Irwin III ezt ?rta:
>>> Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. 

On Sat, Dec 13, 2003 at 08:01:51PM +0100, Gabor MICSKO wrote:
>> Can't boot on my IBM Thinkpad R32. On boot falling in infinite loop. 
>> .config attached

On Sat, Dec 13, 2003 at 11:05:02AM -0800, William Lee Irwin III wrote:
> Can you try without 4K stacks? PCMCIA sometimes barfs on that.

Gabor has reported success with 8K stacks. It's in the "kernel hacking"
section for a good reason. =)


-- wli
