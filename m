Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318729AbSHBHMV>; Fri, 2 Aug 2002 03:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSHBHMV>; Fri, 2 Aug 2002 03:12:21 -0400
Received: from holomorphy.com ([66.224.33.161]:52415 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318729AbSHBHMV>;
	Fri, 2 Aug 2002 03:12:21 -0400
Date: Fri, 2 Aug 2002 00:15:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, davidm@hpl.hp.com,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       rohit.seth@intel.com, sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch
Message-ID: <20020802071513.GI25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>, davidm@hpl.hp.com,
	"David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
	riel@conectiva.com.br, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rohit.seth@intel.com, sunil.saxena@intel.com,
	asit.k.mallick@intel.com
References: <15690.9727.831144.67179@napali.hpl.hp.com> <868823061.1028244804@[10.10.2.3]> <3D4A3002.FFED947E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D4A3002.FFED947E@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Dave Miller wrote:
DaveM>    In my opinion the proposed large-page patch addresses a
DaveM> relatively pressing need for databases (primarily).
DaveM> Databases want large pages with IPC_SHM, how can this
DaveM> special syscal hack address that?

At some point in the past, David Mosberger wrote:
I believe the interface is OK in that regard.  AFAIK, Oracle is happy
with it.

"Martin J. Bligh" wrote:
>> Is Oracle now the world's only database? I think not.

On Fri, Aug 02, 2002 at 12:08:50AM -0700, Andrew Morton wrote:
> Is a draft of Simon's patch available against 2.5?

Unless I can turn blood into wine, walk on water, and produce a working
2.5 version of the thing in < 6 hours (not that I'm not trying), this
will probably have to wait until Hubertus remeterializes tomorrow
morning (EDT) and further porting is done. I'll be up early.

Cheers,
Bill
