Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTL2Ab7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 19:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTL2Ab7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 19:31:59 -0500
Received: from holomorphy.com ([199.26.172.102]:46003 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262198AbTL2Ab6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 19:31:58 -0500
Date: Sun, 28 Dec 2003 16:31:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: mfedyk@matchmail.com, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20031229003150.GS22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mfedyk@matchmail.com, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031227215606.GO18208@waste.org> <20031228235417.GB1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228235417.GB1882@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 03:56:06PM -0600, Matt Mackall wrote:
>> This is the second release of the -tiny kernel tree. The aim of this
>> tree is to collect patches that reduce kernel disk and memory
>> footprint as well as tools for working on small systems. Target users
>> are things like embedded systems, small or legacy desktop folks, and
>> handhelds.
>> Latest release includes:
>>  - "make checkstack" to find largest stack users

On Sun, Dec 28, 2003 at 03:54:17PM -0800, Mike Fedyk wrote:
> Maybe wli will be interested in this one since he has some stack shrinking
> patches in his tree...

I'm already following this in general. I contributed a number of fixes
I've done for the 4K stack code over time at the time mpm originally
put -tiny together, though I think he's rearranged various things (e.g.
re-split the thing into 3 pieces) I can't be arsed to deal with.


-- wli
