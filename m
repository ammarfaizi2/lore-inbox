Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUEMPjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUEMPjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUEMPjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:39:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63637 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264258AbUEMPiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:38:09 -0400
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
From: Dave Hansen <haveblue@us.ibm.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: "'Greg KH'" <greg@kroah.com>, Matt_Domsch@dell.com,
       "'Matthew E Tolentino'" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <012201c438f4$0cbb6580$39624c0f@india.hp.com>
References: <012201c438f4$0cbb6580$39624c0f@india.hp.com>
Content-Type: text/plain
Message-Id: <1084462371.1417.20.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 08:32:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 07:10, Sourav Sen wrote:
> + We're planning on doing this anyway for memory hotplug, so some of the
> + work and ideas are already there.  I'd be happy to point you to some
> + past discussions and code on the subject.  

Here was my sample implementation of how to export memory areas:

http://sourceforge.net/mailarchive/forum.php?thread_id=4120609&forum_id=223

There was at least one other way to do the same thing on the lhms-devel
list.  I believe it was some time last month.

-- Dave

