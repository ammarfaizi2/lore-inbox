Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTHHAO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTHHAO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:14:56 -0400
Received: from holomorphy.com ([66.224.33.161]:35735 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271112AbTHHAOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:14:55 -0400
Date: Thu, 7 Aug 2003 17:16:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm5
Message-ID: <20030808001610.GB32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>
References: <20030806223716.26af3255.akpm@osdl.org> <14340000.1060300025@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14340000.1060300025@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote (on Wednesday, August 06, 2003 22:37:16 -0700):
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/
>> Lots of different things.  Mainly trying to get this tree stabilised again;
>> there has been some breakage lately.

On Thu, Aug 07, 2003 at 04:47:07PM -0700, Martin J. Bligh wrote:
> Mmmm. 4/4 split now boots again, but behaves rather oddly. This is with
> Nick's AS fix, plus the 4/4 fix Andrew sent me last night, which I presume
> is the same as what Bill sent out.
> Difficult to tell what's going on exactly. For one, the machine has lost 
> it's hostname, for another, it seems to have mounted the root fs readonly. 
> End of the bootlog looks like this:

It comes up normally here; not sure what's going on.


-- wli
