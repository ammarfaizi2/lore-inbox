Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265670AbTGIFDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265671AbTGIFDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 01:03:47 -0400
Received: from holomorphy.com ([66.224.33.161]:48552 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265670AbTGIFDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 01:03:46 -0400
Date: Tue, 8 Jul 2003 22:19:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030709051941.GK15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain> <55580000.1057727591@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55580000.1057727591@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, mingo wrote:
>> i'm pleased to announce the first public release of the "4GB/4GB VM split"
>> patch, for the 2.5.74 Linux kernel:
>>    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8

On Tue, Jul 08, 2003 at 10:13:12PM -0700, Martin J. Bligh wrote:
> I presume this was for -bk something as it applies clean to -bk6, but not
> virgin. 
> However, it crashes before console_init on NUMA ;-( I'll shove early printk
> in there later.

Don't worry, I'm debugging it.


-- wli
