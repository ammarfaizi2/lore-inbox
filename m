Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTAJQGj>; Fri, 10 Jan 2003 11:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTAJQGY>; Fri, 10 Jan 2003 11:06:24 -0500
Received: from holomorphy.com ([66.224.33.161]:18842 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265351AbTAJQEv>;
	Fri, 10 Jan 2003 11:04:51 -0500
Date: Fri, 10 Jan 2003 08:13:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel@vger.kernel.org, daniel.ritz@alcatel.ch,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030110161328.GV23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
	Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org,
	daniel.ritz@alcatel.ch, Robert Love <rml@tech9.net>
References: <1042192419.1415.49.camel@cast2.alcatel.ch> <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain> <20030110160334.GU23814@holomorphy.com> <20030110161212.GA11193@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110161212.GA11193@wotan.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> So the end-result of the discussion is, "What should really happen here?"
>> and "What, if anything, do you want me to do?"

On Fri, Jan 10, 2003 at 05:12:12PM +0100, Andi Kleen wrote:
> IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms 
> lookup slow, simple and stupid.

Slow, simple, and stupid == "wli, get the Hell out". I'm gone.


Thanks,
Bill
