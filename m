Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUEMCKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUEMCKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 22:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUEMCKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 22:10:16 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:10727 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263745AbUEMCKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 22:10:04 -0400
From: "Peter J. Braam" <braam@clusterfs.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>, <akpm@osdl.org>,
       "'Yang, Chen'" <chyang@clusterfs.com>
Cc: <intermezzo-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH]InterMezzo Patch against linux-2.6.6
Date: Thu, 13 May 2004 10:09:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.58.0405121631200.3636@evo.osdl.org>
Thread-Index: AcQ4efehWhI0xA/US36UWYm8J4S0DQAEk/mA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040513021000.2A815310162@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

I spoke with Chen and you can just drop InterMezzo now.  It is easy to
maintain as a module outside the kernel, we did that for some years.

- Peter -

> -----Original Message-----
> From: intermezzo-devel-admin@lists.sourceforge.net 
> [mailto:intermezzo-devel-admin@lists.sourceforge.net] On 
> Behalf Of Linus Torvalds
> Sent: Thursday, May 13, 2004 7:35 AM
> To: Yang, Chen
> Cc: Muli Ben-Yehuda; Anton Blanchard; 
> intermezzo-devel@lists.sourceforge.net; 
> linux-kernel@vger.kernel.org; Peter Braam; arjanv@redhat.com; 
> akpm@osdl.org
> Subject: Re: [PATCH]InterMezzo Patch against linux-2.6.6
> 
> 
> 
> On Wed, 12 May 2004, Yang, Chen wrote:
> >
> >    Below is the patch of InterMezzo again linux-2.6.6, I 
> can confirm 
> > that it's effective. I'm sad to see it's removed in bkl. It 
> seems that 
> > this is the last patch for InterMezzo. :(
> 
> It's removed because Peter seems to not want to support it 
> any more, and there didn't seem to be any usage. But if 
> people out there are actually using it, and somebody wants to 
> support it _and_ it is in good working state for 2.6.x, we 
> could certainly bring it back to life.
> 
> But if you only do this because you want to fix warnings that 
> people have posted about the sources, and you're not actually 
> seriously using it and maintaining it, then I'll just apply 
> this patch against plain 2.6.6 (so that it doesn't go away if 
> somebody wants to resurrect it later).
> 
> In other words - holler if you want to seriously support it. 
> We're not deleting it to be spiteful..
> 
> 		Linus
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband 
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> intermezzo-devel mailing list
> intermezzo-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/intermezzo-devel
> 

