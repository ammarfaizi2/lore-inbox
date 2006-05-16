Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWEPQ7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWEPQ7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEPQ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:59:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:10670 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932144AbWEPQ7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:59:45 -0400
Subject: Re: [PATCH] typo in i386/init.c [BugMe #6538]
From: Dave Hansen <haveblue@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060516165040.GA4341@us.ibm.com>
References: <20060516165040.GA4341@us.ibm.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 09:58:16 -0700
Message-Id: <1147798696.6623.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 09:50 -0700, Nishanth Aravamudan wrote:
> Hi Andrew,
> 
> Resending, since I haven't heard anything back yet.
> 
> Description: Fix a small typo in arch/i386/mm/init.c. Confirmed to fix
> BugMe #6538.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Acked-by: Dave Hansen <haveblue@us.ibm.com>

I had a hunk in a patch in my tree that fixed this as part of the
hot-add for i386 debugging patches.  I missed that the upstream patch
had this junk in it.  Thanks for finding it.

-- Dave

