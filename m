Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSEBV5G>; Thu, 2 May 2002 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315460AbSEBV5F>; Thu, 2 May 2002 17:57:05 -0400
Received: from holomorphy.com ([66.224.33.161]:12760 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315459AbSEBV5E>;
	Thu, 2 May 2002 17:57:04 -0400
Date: Thu, 2 May 2002 14:55:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kurt Ferreira <kurdt@nmt.edu>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502215552.GO32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kurt Ferreira <kurdt@nmt.edu>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020502212810.GN32767@holomorphy.com> <Pine.LNX.4.44.0205021549480.618-100000@eldorado.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:20:39PM -0700, Martin J. Bligh wrote:
>> Woops, I forgot about the BAR, thanks. Heck, IIRC you were even the one
>> who told me about this trick.

On Thu, May 02, 2002 at 03:52:53PM -0600, Kurt Ferreira wrote:
> By this do you mean setting bits BAR[2:1]=b'10?  Just making sure I get
> it.
> Thanks
> Kurt

I'm not that well-versed in PCI programming; I don't believe I was told
in any greater level of detail than has already crossed this list.

Cheers,
Bill
