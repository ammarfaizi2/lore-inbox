Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWHQRxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWHQRxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWHQRxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:53:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59340 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932560AbWHQRxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:53:17 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>
In-Reply-To: <1155836198.14617.61.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155835003.14617.45.camel@galaxy.corp.google.com>
	 <1155835401.9274.64.camel@localhost.localdomain>
	 <1155836198.14617.61.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:53:09 -0700
Message-Id: <1155837189.9274.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 10:36 -0700, Rohit Seth wrote:
> On Thu, 2006-08-17 at 10:23 -0700, Dave Hansen wrote:
> > nor is it ambiguous in any way.  It is very strict,
> > and very straightforward.
> 
> What additional ambiguity you have when inode or task structures have
> the required information.

I think _I_ was being too ambiguous.  ;)

When you uniquely assign a kernel object, say mapping->container, there
is no ambiguity.  

-- Dave

