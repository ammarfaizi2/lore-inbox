Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVAFSDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVAFSDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVAFRvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:51:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39554 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262941AbVAFRup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:50:45 -0500
Date: Thu, 6 Jan 2005 09:50:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ray Bryant <raybry@sgi.com>
cc: Andi Kleen <ak@muc.de>, Steve Longerbeam <stevel@mvista.com>,
       Hugh Dickins <hugh@veritas.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
In-Reply-To: <41DD608A.80003@sgi.com>
Message-ID: <Pine.LNX.4.58.0501060947470.16240@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain>
 <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <41DD608A.80003@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Ray Bryant wrote:

> > If nothing happens soon regarding the "other" hugetlb code I will
> > forward port my SLES9 code. It already has NUMA policy support.
> I too have been frustrated by this process.  I think Christoph Lameter
> at SGI is looking at forward porting the "old" lazy hugetlbpage allocation
> code.  Of course, the proof is in the "doing" of this and I am not sure
> what other priorities he has at the moment.

Sorry I did not have time to continue the huge stuff in face of other
things that came up in the fall. I ported the stuff to 2.6.10 yesterday
but it still needs some rework.

Could you sent me the most up to date version of the SLES9 stuff including
any unintegrated changes? I can work though this next week I believe and
post a new huge pages patch.
