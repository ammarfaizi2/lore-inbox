Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVC3TDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVC3TDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVC3TAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:00:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24450 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262398AbVC3Swu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:52:50 -0500
Date: Wed, 30 Mar 2005 10:48:26 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Paul Jackson <pj@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net,
       "Vivek Kashyap [imap]" <kashyapv@us.ibm.com>
Subject: Re: [patch 0/8] CKRM: Core patch set
Message-ID: <20050330184826.GA29736@chandralinux.beaverton.ibm.com>
References: <1112201599.11490.6.camel@localhost> <E1DGgwq-0006eI-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DGgwq-0006eI-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 09:25:44AM -0800, Gerrit Huizenga wrote:
> 
> On Wed, 30 Mar 2005 08:53:19 PST, Dave Hansen wrote:
> > On Tue, 2005-03-29 at 23:03 -0800, Gerrit Huizenga wrote:
> > > The code provides a fairly simple mechanism for adding controllers for
> > > any resource type
> > 
> > Last time I saw the memory controller, it was 3000 lines.  Doesn't seem
> > too simple to me. :)
>  
>  Chandra, Dave's suggestions for the memory controller makes a lot of
>  sense.  Can you post the current code, ported to the patch set that
>  I just posted, to linux-mm for comment?

Yes, it is in the plans. Withing couple of days I will post memory
controller against this patchset, will crosspost to linux-mm then.
