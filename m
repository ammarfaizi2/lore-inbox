Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVHRJ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVHRJ12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVHRJ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:27:28 -0400
Received: from [81.2.110.250] ([81.2.110.250]:59286 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932136AbVHRJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:27:27 -0400
Subject: Re: Multiple virtual address mapping for the same code on IA-64
	linux kernel.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: vamsi krishna <vamsi.krishnak@gmail.com>,
       "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508171246070.17863@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04294461@scsmsx401.amr.corp.intel.com>
	 <3faf0568050816142715f14c2c@mail.gmail.com>
	 <Pine.LNX.4.62.0508171246070.17863@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 10:54:38 +0100
Message-Id: <1124358878.13511.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-17 at 12:52 -0700, Christoph Lameter wrote:
> > compared to small, this may be the reason why amd64 is the fasttest
> > 64-bit process ?

> Itanium processors are the fastest 64bit processors at any given clock 
> frequency.

Perhaps, and the two statements don't contradict. All he was doing was
asking a very sensible architecture question to understand why the IA64
binary was so big.

> Please do not make such inflammatory statements on the 
> ia64 list.

Since when has asking sensible questions been "inflammatory statements".
If thats how you treat the people actually porting to IA64 then its out
of order, at least for linux-kernel, which is where you cross posted.

Alan

