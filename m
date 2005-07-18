Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVGRV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVGRV13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGRV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 17:27:29 -0400
Received: from fmr17.intel.com ([134.134.136.16]:60333 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261916AbVGRV10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 17:27:26 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Rik van Riel <riel@redhat.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Mon, 18 Jul 2005 14:14:02 -0700
User-Agent: KMail/1.5.4
Cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <200507151447.46318.mgross@linux.intel.com> <Pine.LNX.4.61.0507151914300.25957@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0507151914300.25957@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507181414.02262.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 July 2005 16:14, Rik van Riel wrote:
> On Fri, 15 Jul 2005, Mark Gross wrote:
> > What would be wrong in expecting the folks making the driver changes
> > have some story on how they are validating there changes don't break
> > existing working hardware?  I could probly be accomplished in open
> > source with subsystem testing volenteers.
>
> Are you volunteering ?

I am not volunteering.  That last sentence was meant to say "It could 
probubly..."

I'm just poking at a process change that would include a more formal 
validation / testing phase as part of getting change into the stable tree.  I 
don't have any silver bullets.

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  

